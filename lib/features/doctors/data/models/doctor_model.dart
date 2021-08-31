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
      json[kDoctorSpecialization]['name'],
      json[kDoctorAddress],
      phoneNumber: json[kDoctorPhoneNumber] == null
          ? null
          : json[kDoctorPhoneNumber][0][kDoctorPhoneNumber],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kDoctorId: id,
      kDoctorName: name,
      kDoctorSpecialization: {'name': specialization},
      kDoctorAddress: address,
      kDoctorPhoneNumber: phoneNumber == null
          ? null
          : [
              {kDoctorPhoneNumber: phoneNumber}
            ],
    };
  }

  factory DoctorModel.fromParent(Doctor doctor) {
    return DoctorModel(
      doctor.id,
      doctor.name,
      doctor.specialization,
      doctor.address,
      phoneNumber: doctor.phoneNumber,
    );
  }
}
