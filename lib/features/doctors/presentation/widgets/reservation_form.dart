import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constaints.dart';
import '../../../reservations/domain/entities/reservation.dart';
import '../../../reservations/presentation/cubit/reservations_cubit.dart';

class AddReservationForm extends StatefulWidget {
  final _doctorId;
  final BuildContext _context;

  const AddReservationForm(this._doctorId, this._context);

  @override
  _AddReservationFormState createState() => _AddReservationFormState();
}

class _AddReservationFormState extends State<AddReservationForm> {
  DateTime? _reservDate;

  Future<void> _submit() async {
    if (_reservDate == null) {
      _showErrorToast('الرجاء اختيار تاريخ الحجز');
      return;
    }

    SharedPreferences shared = await SharedPreferences.getInstance();
    final token = shared.getString(kTokenKey) ?? '';

    final reservation = Reservation(
      widget._doctorId,
      token,
      _reservDate!,
    );

    final reservCubit = BlocProvider.of<ReservationsCubit>(context);
    reservCubit.addReservation(reservation);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 22),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 3.0),
        borderRadius: BorderRadius.circular(2.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'اضف موعد الحجز:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2 - 22,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 8,
                    primary: Colors.red,
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
                          setState(() {
                            _reservDate = value;
                          });
                        }
                      },
                    );
                  },
                  icon: Icon(Icons.date_range_outlined),
                  label: Text('موعد الحجز'),
                ),
              ),
              SizedBox(width: 24),
              _reservDate == null
                  ? SizedBox()
                  : Text(
                      _getArabicDate(_reservDate!),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
          SizedBox(height: 14),
          BlocConsumer<ReservationsCubit, ReservationsState>(
            listener: (_, state) {
              if (state is ReservationError)
                _showErrorToast(state.message);
              else if (state is AddedReservation) {
                if (state.isSuccess)
                  Navigator.of(context).pop(widget._context);
                else
                  _showErrorToast('لم ينجح تثبيت الحجز جرب مرة أخرى');
              }
            },
            builder: (_, state) {
              if (state is Loading) return CircularProgressIndicator();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      elevation: 8,
                    ),
                    child: Text('تثبيت الحجز'),
                    onPressed: _submit,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showErrorToast(String message) {}
}

String _getArabicDate(DateTime dateTime) {
  final day = dateTime.weekday;
  final date = DateFormat('M/d').format(dateTime);
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
  return '$dayName  $date';
}
