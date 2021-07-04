

import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/features/consultations/domain/repositories/consultation_repo.dart';

class GetCons{
  final ConsultationRepo _repo;

  GetCons(this._repo);

  Future<Either<Failure,List<Consultation>>> call() async {
    return _repo.getCons();
  }
}