import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

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
      padding: const EdgeInsets.all(10.0),
      itemCount: widget._reservations.length,
      itemBuilder: (_, i) => Card(
        elevation: 4,
        child: ListTile(
          leading: Icon(Icons.medical_services_outlined),
          title: Text(widget._reservations[i].doctorName ?? ''),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat('m/d').format(widget._reservations[i].date)),
              SizedBox(width: 4),
              Text(
                'الساعة',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                '${DateFormat('HH').format(widget._reservations[i].date)} :',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Text(
            '${widget._reservations[i].status}',
            style: TextStyle(color: Colors.red.shade300),
          ),
        ),
      ),
    );
  }
}
