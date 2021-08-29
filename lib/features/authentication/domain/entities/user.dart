import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String token;
  DateTime? expiryTime;
  String? name;
  String? phoneNumber;
  int? age;

  User(
    this.token, {
    this.expiryTime,
    this.name,
    this.phoneNumber,
    this.age,
  });

  bool isAuth() => token.isNotEmpty;

  @override
  List<Object?> get props => [token];
}
