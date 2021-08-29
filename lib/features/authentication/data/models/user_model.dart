import 'package:tabibi/core/utils/constaints.dart';

import '../../domain/entities/user.dart';

// ignore: must_be_immutable
class UserModel extends User {
  UserModel(
    token,
  ) : super(token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json[kTokenKey],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kTokenKey: token,
    };
  }
}
