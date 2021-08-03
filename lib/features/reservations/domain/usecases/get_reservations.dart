import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetResevations {
  final ReservationRepo _repo;

  GetResevations(this._repo);

  Future<Either<Failure, List<Reservation>>> call() async {
    return _repo.getReservations();
  }
}
