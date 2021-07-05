import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/network/internet_info.dart';
import 'package:tabibi/features/consultations/data/data%20sources/cons_ds.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tabibi/features/consultations/domain/repositories/consultation_repo.dart';

class ConsultationRepoImpl extends ConsultationRepo {
  final ConsultationDS _consultationDS;
  final InternetInfo _internetInfo;

  ConsultationRepoImpl(this._consultationDS, this._internetInfo);

  @override
  Future<bool> addConsultation(Consultation consultation) async {
    if (await _internetInfo.isConnect) {
      final result = await _consultationDS.addConsultation(consultation);
      return result;
    } else
      return false;
  }

  @override
  Future<Either<Failure, List<Consultation>>> getCons() async =>
      _fetchCons(() => _consultationDS.getConsultations());

  @override
  Future<Either<Failure, List<Consultation>>> getConsBySpeci(
    String specialization,
  ) async =>
      _fetchCons(() => _consultationDS.getConsultationsBySpeci(specialization));

  @override
  Future<Either<Failure, List<Consultation>>> getMyCons(
    String userId,
  ) async =>
      _fetchCons(() => _consultationDS.getMyConsultatioins(userId));

  Future<Either<Failure, List<Consultation>>> _fetchCons(Function call) async {
    if (await _internetInfo.isConnect) {
      try {
        final cons = await call();
        return Right(cons);
      } on HttpException catch (e) {
        return Left(HttpFailure(e.message));
      }
    } else
      return Left(InternetFailure());
  }
}
