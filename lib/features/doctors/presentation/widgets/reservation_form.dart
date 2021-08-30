import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/funcs.dart';
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

  void _submit() {
    if (_reservDate == null) {
      _showErrorToast('الرجاء اختيار تاريخ الحجز');
      return;
    }

    final reservation = Reservation(
      1,
      widget._doctorId,
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
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
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
                      getArabicDate(_reservDate!),
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
              if (state is AddedReservation) {
                print(state.isSuccess);
                if (state.isSuccess)
                  Navigator.of(context).pop(widget._context);
                else
                  _showErrorToast('لم يُثبت الحجز جرب مرةأخرى');
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

  void _showErrorToast(String message) {
    //toast
  }
}
