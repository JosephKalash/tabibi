import 'package:tabibi/core/utils/constaints.dart';

import '../../domain/entities/user.dart';

// ignore: must_be_immutable
class UserModel extends User {
  UserModel(
    userId,
    token,
    expiryTime,
  ) : super(userId, token, expiryTime);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json[kLocalIdKey],
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
      kLocalIdKey: userId,
      kExpiresInKey: expiryTime?.toIso8601String(),
    };
  }
}
