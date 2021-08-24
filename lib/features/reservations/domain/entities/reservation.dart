import 'package:equatable/equatable.dart';

enum ReservationStatus {
  None,
  Accept,
  Reject,
}

class Reservation extends Equatable {
  final doctorId;
  final DateTime date;
  final ReservationStatus? status;
  final String? doctorName;

  Reservation(
    this.doctorId,
    this.date, {
    this.status,
    this.doctorName,
  });

  @override
  List<Object?> get props => [
        doctorId,
        date,
        status,
        doctorName,
      ];
}
