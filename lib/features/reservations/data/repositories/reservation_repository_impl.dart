import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/network/internet_info.dart';
import 'package:tabibi/features/reservations/data/data%20sources/reservation_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';

class ReservationRepoImpl extends ReservationRepo {
  final ReservationDS _ds;
  final InternetInfo _internetInfo;

  ReservationRepoImpl(this._ds, this._internetInfo);

  @override
  Future<bool> addReservation(Reservation reservation) async {
    return _editReservation(() => _ds.addReservation(reservation));
  }

  @override
  Future<bool> cancelReservation(Reservation reservation) async {
    return _editReservation(() => _ds.cancelReservation(reservation));
  }

  Future<bool> _editReservation(Function call) async {
    if (await _internetInfo.isConnect) {
      try {
        final result = await call();
        return result;
      } on Exception {
        return false;
      }
    } else
      return false;
  }

  @override
  Future<Either<Failure, List<Reservation>>> getReservations() async {
    if (await _internetInfo.isConnect) {
      try {
        final result = await _ds.getReservation();
        return Right(result);
      } on HttpException catch (e) {
        return Left(HttpFailure(e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else
      return Left(InternetFailure());
  }
}
