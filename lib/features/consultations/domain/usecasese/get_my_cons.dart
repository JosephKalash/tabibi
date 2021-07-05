

import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/features/consultations/domain/repositories/consultation_repo.dart';

class GetMyCons extends Usecase{
  final ConsultationRepo _repo;

  GetMyCons(this._repo);

  Future<Either<Failure,List<Consultation>>> call(String userId) async {
    return _repo.getMyCons(userId);
  }
}