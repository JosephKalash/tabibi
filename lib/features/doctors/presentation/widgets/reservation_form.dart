import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';
import 'package:tabibi/features/reservations/presentation/cubit/reservations_cubit.dart';

class AddReservationForm extends StatefulWidget {
  final _doctorId;
  final BuildContext _context;

  const AddReservationForm(this._doctorId, this._context);

  @override
  _AddReservationFormState createState() => _AddReservationFormState();
}

class _AddReservationFormState extends State<AddReservationForm> {
  DateTime? _reservDate;
  ReservationType? _type;

  Future<void> _submit() async {
    if (_reservDate == null) _snackbar('الرجاء اختيار تاريخ الحجز');

    SharedPreferences shared = await SharedPreferences.getInstance();
    final map = json.decode(shared.getString(kauthPref) ?? '');

    Reservation reservation = Reservation(
      widget._doctorId,
      map[kUserIdKey],
      _reservDate!,
      _type ?? ReservationType.None,
    );

    final reservCubit = BlocProvider.of<ReservationsCubit>(context);
    reservCubit.addReservation(reservation);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('اضافة حجز جديد'),
          SizedBox(height: 4),
          Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 8,
                  primary: Colors.blue,
                ),
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 30)),
                  ).then(
                    (DateTime? value) {
                      if (value != null) {
                        _reservDate = value;
                      }
                    },
                  );
                },
                icon: Icon(Icons.date_range_outlined),
                label: Text('موعد الحجز'),
              ),
              SizedBox(width: 10),
              _reservDate == null
                  ? SizedBox()
                  : Text(_getArabicDate(_reservDate!)),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.red.shade700),
                onPressed: () async {
                  showDialog<ReservationType>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('اختر نوع الحجز'),
                      content: Column(
                        children: ReservationType.values
                            .map((e) => Row(
                                  children: [
                                    Radio<ReservationType>(
                                      value: e,
                                      groupValue: ReservationType.None,
                                      onChanged: (value) {
                                        setState(() {
                                          _type = value;
                                        });
                                      },
                                    ),
                                    Text(_getArabicReservationType(e)),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.list_alt_outlined),
                label: Text('نوع الحجز'),
              ),
              SizedBox(width: 10),
              _type == null
                  ? SizedBox()
                  : Text(_getArabicReservationType(_type!)),
            ],
          ),
          SizedBox(height: 4),
          BlocBuilder<ReservationsCubit, ReservationsState>(
            builder: (_, state) {
              if (state is Loading)
                return CircularProgressIndicator();
              else if (state is ReservationError)
                _snackbar(state.message);
              else if (state is AddedReservation)
                Navigator.of(context).pop(widget._context);
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  elevation: 8,
                ),
                child: Text('ارسال'),
                onPressed: _submit,
              );
            },
          ),
        ],
      ),
    );
  }

  void _snackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}

String _getArabicReservationType(ReservationType type) {
  String temp;
  switch (type) {
    default:
      temp = 'أخر';
  }
  return temp;
}

String _getArabicDate(DateTime dateTime) {
  final day = dateTime.weekday;
  final date = DateFormat.MONTH_DAY;
  String dayName;
  switch (day) {
    case 1:
      dayName = 'الأثنين';
      break;
    case 2:
      dayName = 'الثلاثاء';
      break;
    case 3:
      dayName = 'الأربعاء';
      break;
    case 4:
      dayName = 'الخميس';
      break;
    case 5:
      dayName = 'الجمعة';
      break;
    case 6:
      dayName = 'السبت';
      break;
    case 7:
      dayName = 'الأحد';
      break;
    default:
      dayName = '';
      break;
  }
  return '$dayName $date';
}
