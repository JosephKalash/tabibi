import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/funcs.dart';
import '../../../reservations/domain/entities/reservation.dart';
import '../../../reservations/presentation/cubit/reservations_cubit.dart';

class ReservationsList extends StatefulWidget {
  final List<Reservation> _reservations;

  const ReservationsList(this._reservations);

  @override
  _ReservationsListState createState() => _ReservationsListState();
}

class _ReservationsListState extends State<ReservationsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 26),
      itemCount: widget._reservations.length,
      itemBuilder: (_, i) => Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 4,
        child: ListTile(
          title: Text(widget._reservations[i].doctorName ?? 'لا يوجد أسم'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                getArabicDate(widget._reservations[i].date),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                'الساعة',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                ': ${widget._reservations[i].time??'00:00'}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                _getArabicReservationType(widget._reservations[i].status),
                style: TextStyle(color: Colors.green.shade500),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                onPressed: () async {
                  bool? confirmed = await _showDeleteDialoge(context);
                  if (confirmed == null || !confirmed) return;
                  BlocProvider.of<ReservationsCubit>(
                    context,
                    listen: false,
                  ).cancelReservation(widget._reservations[i]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getArabicReservationType(ReservationStatus? status) {
    if (status == null) return 'غير محدد';
    switch (status) {
      case ReservationStatus.waiting:
        return 'بأنتظار التأكيد';
      case ReservationStatus.Accept:
        return 'مؤكد';
      case ReservationStatus.Reject:
        return 'مرفوض';
      default:
        return 'غير محدد';
    }
  }
}

Future<bool?> _showDeleteDialoge(context) async {
  return showDialog<bool>(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          'ألغاء الحجز',
          style: TextStyle(fontSize: 18),
        ),
        content: Text('هل أنت متأكد من ألغاء الحجز؟'),
        actions: [
          TextButton(
            child: Text(
              'تأكيد',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          TextButton(
            child: Text('ألغاء'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          )
        ],
      );
    },
  );
}
