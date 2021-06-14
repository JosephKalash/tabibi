import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel(
    userId,
    token,
    expiryTime,
  ) : super(userId, token, expiryTime);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['localId'],
      json['idToken'],
      DateTime.now().add(Duration(
        seconds: int.parse(json['expiresIn']),
      )),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'localId': userId,
      'idToken': token,
      'expiresIn': expiryTime.toIso8601String(), 
    };
  }
}
