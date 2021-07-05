import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/features/consultations/domain/repositories/consultation_repo.dart';

class AddCons extends Usecase {
  final ConsultationRepo _repo;

  AddCons(this._repo);

  Future<bool> call(Consultation consultation) async {
    return _repo.addConsultation(consultation);
  }
}
