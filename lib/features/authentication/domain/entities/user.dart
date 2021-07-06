import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String userId;
  String token;
  DateTime? expiryTime;
  String? name;
  String? phoneNumber;
  double? age;

  User(
    this.userId,
    this.token,
    this.expiryTime,
  );

  bool isAuth() => token.isNotEmpty;
  
  @override
  List<Object?> get props => [
        userId,
        token,
        expiryTime?.toIso8601String(),
      ];
}
