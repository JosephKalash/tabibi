
import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

abstract class ConsultationRepo{
  Future<bool> addConsultation(Consultation consultation);
  Future<Either<Failure,List<Consultation>>> getCons();
  Future<Either<Failure,List<Consultation>>> getMyCons(String userId);
  Future<Either<Failure,List<Consultation>>> getConsBySpeci(String specialization);
}