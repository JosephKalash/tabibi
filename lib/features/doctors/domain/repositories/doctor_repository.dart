import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';

abstract class DoctorRepo {
  Future<Either<Failure, List<Doctor>>> getDoctors();
}
