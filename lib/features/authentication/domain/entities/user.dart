import 'package:equatable/equatable.dart';

class User extends Equatable {
  final _userId;
  final _token;
  final DateTime _expiryTime;

  User(
    this._userId,
    this._token,
    this._expiryTime,
  );

  get userId => _userId;
  get token => _token;
  DateTime get expiryTime => _expiryTime;

  @override
  List<Object?> get props => [
        _userId,
        _token,
        _expiryTime,
      ];
}
