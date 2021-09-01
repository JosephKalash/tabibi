import 'package:equatable/equatable.dart';

enum ReservationStatus {
  None,
  Accept,
  Reject,
  waiting,
}

class Reservation extends Equatable {
  final id;
  final doctorId;
  final DateTime date;
  final ReservationStatus? status;
  final String? doctorName;
  final dynamic? time;

  Reservation(
    this.id,
    this.doctorId,
    this.date, {
    this.status,
    this.doctorName,
    this.time,
  });

  @override
  List<Object?> get props => [
        id,
        doctorId,
        date,
        status,
        doctorName,
        time,
      ];
}
