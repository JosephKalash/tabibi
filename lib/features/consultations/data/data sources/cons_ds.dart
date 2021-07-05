import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

abstract class ConsultationDS {
  Future<bool> addConsultation(Consultation consultation);
  Future<List<Consultation>> getConsultations();
  Future<List<Consultation>> getMyConsultatioins(String userId);
  Future<List<Consultation>> getConsultationsBySpeci(String specialization);
}
