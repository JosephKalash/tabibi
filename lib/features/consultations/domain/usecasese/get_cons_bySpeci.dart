

import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/features/consultations/domain/repositories/consultation_repo.dart';

class GetConsBySpeci{
  final ConsultationRepo _repo;

  GetConsBySpeci(this._repo);

  Future<Either<Failure,List<Consultation>>> call(String specialization) async {
    return _repo.getConsBySpeci(specialization);
  }
}