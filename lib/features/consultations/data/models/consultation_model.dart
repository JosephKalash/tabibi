import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/cons_response_model.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

// ignore: must_be_immutable
class ConsultationModel extends Consultation {
  ConsultationModel(
    clinicSpecialization,
    title,
    content,
    DateTime date, {
    ConsResponseModel? consResponse,
  }) : super(clinicSpecialization, title, content, date,
            consResponse: consResponse);

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      json[kClinicSpecialization],
      json[kTitle],
      json[kContent],
      DateTime.parse(json[kConsDate]),
      consResponse: (json[kConResponse] != null && json[kConResponse] != '')
          ? ConsResponseModel.fromJson(json)
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kClinicSpecialization: clinicSpecialization,
      kTitle: title,
      kContent: content,
      kConsDate: date.toIso8601String(),
    };
  }

  factory ConsultationModel.fromParent(Consultation consultation) {
    return ConsultationModel(
      consultation.clinicSpecialization,
      consultation.title,
      consultation.content,
      consultation.date,
    );
  }
}
