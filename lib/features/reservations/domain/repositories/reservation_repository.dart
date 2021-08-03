import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

abstract class ReservationRepo {
  Future<bool> addReservation(Reservation reservation);
  Future<Either<Failure, List<Reservation>>> getReservations();
  Future<bool> cancelReservation(Reservation reservation);
}
