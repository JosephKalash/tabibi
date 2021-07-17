import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/network/internet_info.dart';
import 'package:tabibi/features/specializations/data/data%20sources/specialization_DS.dart';
import 'package:tabibi/features/specializations/domain/entities/specialization.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tabibi/features/specializations/domain/repositories/special_repo.dart';

class SpeciRepoImpl extends SpecialRepo {
  final InternetInfo _internetInfo;
  final SpecializationDS _speciDs;

  SpeciRepoImpl(this._internetInfo, this._speciDs);

  @override
  Future<Either<Failure, List<Specialization>>> getSpecializations() async {
    if (await _internetInfo.isConnect) {
      try {
        final result = await _speciDs.getSpecializations();
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
