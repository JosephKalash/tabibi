import 'package:equatable/equatable.dart';

enum ReservationStatus {
  None,
}
enum ReservationType {
  None,
}

class Reservation extends Equatable {
  final DateTime date;
  final ReservationType type;
  final ReservationStatus? status;

  Reservation(
    this.date,
    this.type, {
    this.status,
  });

  @override
  List<Object?> get props => [
        date,
        type,
        status,
      ];
}
