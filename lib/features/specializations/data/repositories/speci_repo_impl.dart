import 'package:dartz/dartz.dart';

import '../../../../core/error/excpetions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/internet_info.dart';
import '../../domain/entities/specialization.dart';
import '../../domain/repositories/special_repo.dart';
import '../data%20sources/specialization_DS.dart';

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
