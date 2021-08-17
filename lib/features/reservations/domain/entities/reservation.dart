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
  final String? doctorName;

  Reservation(
    this.doctorId,
    this.userId,
    this.date,
    this.type, {
    this.status,
    this.doctorName,
  });

  @override
  List<Object?> get props => [
        doctorId,
        userId,
        date,
        type,
        status,
        doctorName,
      ];
}
