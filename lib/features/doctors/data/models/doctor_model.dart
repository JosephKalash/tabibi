import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';

class DoctorModel extends Doctor {
  DoctorModel(
    name,
    specialization,
    location, {
    phoneNumber,
    imagePath,
  }) : super(name, specialization, location,
            phoneNumber: phoneNumber, imagePath: imagePath);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      json[kDoctorName],
      json[kDoctorSpecialization],
      json[kDoctorLocation],
      phoneNumber: json[kDoctorPhoneNumber],
      imagePath: json[kDoctorImagePath],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kDoctorName: name,
      kDoctorSpecialization: specialization,
      kDoctorLocation: location,
      kDoctorPhoneNumber: phoneNumber ?? '',
      kDoctorImagePath: imagePath ?? '',
    };
  }
}
