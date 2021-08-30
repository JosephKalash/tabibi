import '../../../../core/utils/constaints.dart';
import '../../domain/entities/consultation.dart';
import 'cons_response_model.dart';

// ignore: must_be_immutable
class ConsultationModel extends Consultation {
  ConsultationModel(
    clinicSpecialization,
    title,
    content,
    DateTime date, {
    int? patientAge,
    ConsResponseModel? consResponse,
  }) : super(
          clinicSpecialization,
          title,
          content,
          date,
          patientAge: patientAge,
          consResponse: consResponse,
        );

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      json[kClinicSpecialization],
      json[kTitle],
      json[kContent],
      DateTime.parse(json[kConsDate]),
      patientAge: json[kUserAge],
      consResponse:
          json[kConResponse] == null ? null : ConsResponseModel.fromJson(json),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'patient_Id': 1,
      kClinicSpecialization: clinicSpecialization,
      kTitle: title,
      kContent: content,
      kConsDate: date.toIso8601String(),
      kUserAge: patientAge ?? null,
      kConResponse: consResponse?.response,
      kDoctorName: consResponse?.doctorName,
      kResponseDate: consResponse?.date.toIso8601String(),
    };
  }

  factory ConsultationModel.fromParent(Consultation consultation) {
    print(consultation.consResponse);
    return ConsultationModel(
      consultation.clinicSpecialization,
      consultation.title,
      consultation.content,
      consultation.date,
      patientAge: consultation.patientAge,
      consResponse: consultation.consResponse == null
          ? null
          : ConsResponseModel.fromParent(consultation.consResponse!),
    );
  }
}
