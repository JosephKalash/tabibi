
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tabibi/features/reservations/domain/repositories/reservation_repository.dart';

class ReservationRepoImpl extends ReservationRepo{
  @override
  Future<bool> addReservation(Reservation reservation) {
    // TODO: implement addReservation
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelReservation(Reservation reservation) {
    // TODO: implement cancelReservation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Reservation>>> getReservations() {
    // TODO: implement getReservations
    throw UnimplementedError();
  }
}