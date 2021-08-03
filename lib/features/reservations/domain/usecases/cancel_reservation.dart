import 'package:tabibi/features/reservations/domain/entities/reservation.dart';
import 'package:tabibi/features/reservations/domain/repositories/reservation_repository.dart';

class CancelReservation {
  final ReservationRepo _repo;

  CancelReservation(this._repo);

  Future<bool> call(Reservation reservation) async {
    return _repo.cancelReservation(reservation);
  }
}
