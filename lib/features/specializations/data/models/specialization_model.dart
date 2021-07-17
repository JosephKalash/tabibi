import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/specializations/domain/entities/specialization.dart';

class SpecializationModel extends Specialization {
  SpecializationModel(String name, String value) : super(name, value);

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      json[kSpeciName],
      json[kSpeciValue],
    );
  }
  Map<String, dynamic> toJson(Specialization specialization) {
    return {
      kSpeciName: specialization.name,
      kSpeciValue: specialization.value,
    };
  }
}
