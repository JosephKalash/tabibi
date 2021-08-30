import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/network/internet_info.dart';
import 'package:tabibi/features/doctors/data/data%20source/doctor_DS.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tabibi/features/doctors/domain/repositories/doctor_repository.dart';

class DoctorRepoImpl extends DoctorRepo {
  final InternetInfo _internetInfo;
  final DoctorDS _doctorDS;

  DoctorRepoImpl(this._internetInfo, this._doctorDS);

  @override
  Future<Either<Failure, List<Doctor>>> getDoctors() async {
    if (await _internetInfo.isConnect) {
      try {
        final result = await _doctorDS.getDoctor();
        return right(result);
      } on HttpException catch (e) {
        return Left(HttpFailure(e.message));
      } on Exception {
        print('exception');
        return Left(ServerFailure());
      }
    } else
      return Left(InternetFailure());
  }
}
