import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/specializations/domain/entities/specialization.dart';
import 'package:tabibi/features/specializations/domain/repositories/special_repo.dart';

class GetSpecials {
  final SpecialRepo _repo;

  GetSpecials(this._repo);

  Future<Either<Failure, List<Specialization>>> call() async {
    return _repo.getSpecializations();
  }
}
