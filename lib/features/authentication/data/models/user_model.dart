import 'package:tabibi/core/utils/constaints.dart';

import '../../domain/entities/user.dart';

// ignore: must_be_immutable
class UserModel extends User {
  UserModel(
    token,
    expiryTime,
  ) : super( token, expiryTime);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json[kTokenKey],
      json[kExpiresInKey] == null || json[kExpiresInKey] == ''
          ? null
          : DateTime.now().add(Duration(
              seconds: int.parse(json[kExpiresInKey]),
            )),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kTokenKey: token,
      kExpiresInKey: expiryTime?.toIso8601String(),
    };
  }
}
