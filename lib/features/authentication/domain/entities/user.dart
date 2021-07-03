import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  String userId;
  String token;
  DateTime? expiryTime;

  User(
    this.userId,
    this.token,
    this.expiryTime,
  );

  @override
  List<Object?> get props => [
        userId,
        token,
        expiryTime,
      ];
}
