import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';
import 'package:tabibi/features/reservations/domain/repositories/reservation_repository.dart';

class AddReservation extends Usecase {
  final ReservationRepo _repo;

  AddReservation(this._repo);

  Future<bool> call(Reservation reservation) async {
    return _repo.addReservation(reservation);
  }
}
