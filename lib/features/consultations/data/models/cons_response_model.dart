import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/domain/entities/cons_response.dart';

class ConsResponseModel extends ConsResponse {
  ConsResponseModel(
    response,
    doctorName,
    DateTime date,
  ) : super(response, doctorName, date);

  factory ConsResponseModel.fromJson(Map<String, dynamic> json) {
    return ConsResponseModel(
      json[kConResponse],
      json[kDoctorName],
      DateTime.parse(json[kResponseDate]),
    );
  }
  Map<String, String> toJson() {
    return {
      kConResponse: response,
      kDoctorName: doctorName,
      kResponseDate: date.toIso8601String(),
    };
  }
}