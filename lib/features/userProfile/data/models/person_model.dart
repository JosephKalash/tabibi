import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/userProfile/domain/entities/person.dart';

class PersonModel extends Person {
  PersonModel(
    name,
    age,
    phoneNumber,
    email,
  ) : super(name, age, phoneNumber,email);

  factory PersonModel.fromJson(Map<String, dynamic> map) {
    return PersonModel(
      map[kUserName],
      map[kUserAge],
      map[kUserPhoneNumber],
      map[kUserEmail],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kUserName: name,
      kUserAge: age,
      kUserPhoneNumber: phoneNumber,
      kUserEmail: email,
    };
  }
}
