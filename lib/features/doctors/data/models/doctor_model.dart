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
  }) : super(id, name, specialization, location,
            phoneNumber: phoneNumber, imagePath: imagePath);

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      json[kDoctorId],
      json[kDoctorName],
      json[kDoctorSpecialization],
      json[kDoctorAddress],
      phoneNumber: json[kDoctorPhoneNumber]??null,
      imagePath: json[kDoctorImagePath]??null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kDoctorId: id,
      kDoctorName: name,
      kDoctorSpecialization: specialization,
      kDoctorAddress: address,
      kDoctorPhoneNumber: phoneNumber ?? null,
      kDoctorImagePath: imagePath ?? null,
    };
  }

  factory DoctorModel.fromParent(Doctor doctor) {
    return DoctorModel(
      doctor.id,
      doctor.name,
      doctor.specialization,
      doctor.address,
      phoneNumber: doctor.phoneNumber,
      imagePath: doctor.imagePath,
    );
  }
}
