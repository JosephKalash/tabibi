import 'package:equatable/equatable.dart';

enum ReservationStatus {
  None,
}
enum ReservationType {
  None,
}

class Reservation extends Equatable {
  final doctorId;
  final userId;
  final DateTime date;
  final ReservationType type;
  final ReservationStatus? status;

  Reservation(
    this.doctorId,
    this.userId,
    this.date,
    this.type, {
    this.status,
  });

  @override
  List<Object?> get props => [
        doctorId,
        date,
        type,
        status,
      ];
}
