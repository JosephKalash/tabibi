import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String token;
  DateTime? expiryTime;
  String? name;
  String? phoneNumber;
  int? age;

  User(
    this.token,
    this.expiryTime,
  );

  bool isAuth() => token.isNotEmpty;
  
  @override
  List<Object?> get props => [
        token,
        expiryTime?.toIso8601String(),
      ];
}
