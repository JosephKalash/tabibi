import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/specializations/domain/entities/specialization.dart';

abstract class SpecialRepo {
  Future<Either<Failure, List<Specialization>>> getSpecializations();
}
