import 'package:equatable/equatable.dart';

enum ReservationStatus {
  None,
}

class Reservation extends Equatable {
  final doctorId;
  final userId;
  final DateTime date;
  final ReservationStatus? status;
  final String? doctorName;

  Reservation(
    this.doctorId,
    this.userId,
    this.date,
     {
    this.status,
    this.doctorName,
  });

  @override
  List<Object?> get props => [
        doctorId,
        userId,
        date,
        status,
        doctorName,
      ];
}
