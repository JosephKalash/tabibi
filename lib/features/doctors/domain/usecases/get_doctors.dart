import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';
import 'package:tabibi/features/doctors/domain/repositories/doctor_repository.dart';

class GetDoctors {
  final DoctorRepo _doctorRepo;

  GetDoctors(this._doctorRepo);

  Future<Either<Failure, List<Doctor>>> call() async {
    return _doctorRepo.getDoctors();
  }
}
