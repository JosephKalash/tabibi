import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

abstract class ReservationDS {
  Future<bool> addReservation(Reservation reservation);
  Future<Either<Failure, List<Reservation>>> getReservation();
  Future<bool> cancelReservation();
}

class reservationDSImpl extends ReservationDS{
  @override
  Future<bool> addReservation(Reservation reservation) {
    // TODO: implement addReservation
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelReservation() {
    // TODO: implement cancelReservation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Reservation>>> getReservation() {
    // TODO: implement getReservation
    throw UnimplementedError();
  }

}
