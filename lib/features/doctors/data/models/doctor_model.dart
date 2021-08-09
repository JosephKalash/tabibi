import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';

// ignore: must_be_immutable
class DoctorModel extends Doctor {
  DoctorModel(
    id,
    name,
    specialization,
    location, {
    phoneNumber,
    imagePath,
  }) : super(id,name, specialization, location,
            phoneNumber: phoneNumber, imagePath: imagePath);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      json[kDoctorId],
      json[kDoctorName],
      json[kDoctorSpecialization],
      json[kDoctorLocation],
      phoneNumber: json[kDoctorPhoneNumber],
      imagePath: json[kDoctorImagePath],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kDoctorId :id,
      kDoctorName: name,
      kDoctorSpecialization: specialization,
      kDoctorLocation: address,
      kDoctorPhoneNumber: phoneNumber ?? '',
      kDoctorImagePath: imagePath ?? '',
    };
  }
}
