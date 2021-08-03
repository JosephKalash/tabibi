enum ReservationStatus {
  None,
}
enum ReservationType {
  None,
}

class Reservation {
  final DateTime date;
  final ReservationType type;
  final ReservationStatus? status;

  Reservation(
    this.date,
    this.type, {
    this.status,
  });
}
