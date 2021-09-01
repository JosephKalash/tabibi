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
      json['clinic'] == null?null:json['clinic'][kDoctorName],
      DateTime.parse(json[kResponseDate]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kConResponse: response,
      'clinic': {kDoctorName: doctorName},
      kResponseDate: date.toIso8601String(),
    };
  }

  factory ConsResponseModel.fromParent(ConsResponse consResponse) {
    return ConsResponseModel(
      consResponse.response,
      consResponse.doctorName,
      consResponse.date,
    );
  }
}
