import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/specializations/domain/entities/specialization.dart';

class SpecializationModel extends Specialization {
  SpecializationModel(
    String id,
    String name,
  ) : super(id, name);

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(
      json[kSpeciId],
      json[kSpeciName],
    );
  }
  Map<String, dynamic> toJson(Specialization specialization) {
    return {
      kSpeciId: specialization.id,
      kSpeciName: specialization.name,
    };
  }
}
