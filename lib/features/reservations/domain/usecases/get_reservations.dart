import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservations {
  final ReservationRepo _repo;

  GetReservations(this._repo);

  Future<Either<Failure, List<Reservation>>> call() async {
    return _repo.getReservations();
  }
}
