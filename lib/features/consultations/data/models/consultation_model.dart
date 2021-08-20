import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/cons_response_model.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

// ignore: must_be_immutable
class ConsultationModel extends Consultation {
  ConsultationModel(
    
    clinicSpecialization,
    title,
    content,
    DateTime date,
     {
    String? userId,
    int? patientAge,
    ConsResponseModel? consResponse,

  }) : super(
  
          clinicSpecialization,
          title,
          content,
          date,
          userId: userId,
          patientAge:patientAge,
          consResponse: consResponse,
        );

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      json[kClinicSpecialization],
      json[kTitle],
      json[kContent],
      DateTime.parse(json[kConsDate]),
      userId: json[kUserIdKey],
      patientAge:json[kUserAge],
      consResponse: (json[kConResponse] != null && json[kConResponse] != {})
          ? ConsResponseModel.fromJson(json[kConResponse])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kClinicSpecialization: clinicSpecialization,
      kTitle: title,
      kContent: content,
      kConsDate: date.toIso8601String(),
      kUserIdKey:userId??null,
      kUserAge:patientAge??null,
      kConResponse: consResponse == null
          ? null
          : {
              kconsAnswer: consResponse!.response,
              kDoctorName: consResponse!.doctorName,
              kResponseDate: consResponse!.date.toIso8601String(),
            },
    };
  }

  factory ConsultationModel.fromParent(Consultation consultation) {
    print(consultation.consResponse);
    return ConsultationModel(
      consultation.clinicSpecialization,
      consultation.title,
      consultation.content,
      consultation.date,
      userId:consultation.userId,
      patientAge: consultation.patientAge,
      consResponse: consultation.consResponse == null
          ? null
          : ConsResponseModel.fromParent(consultation.consResponse!),
    );
  }
}
