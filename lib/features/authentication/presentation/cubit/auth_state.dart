part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final User _user;

  AuthenticatedState(this._user);

  User get user => _user;

  @override
  List<Object> get props => [_user];
}
class LogoutState extends AuthState {
  final User _user;

  LogoutState(this._user);

  User get user => _user;

  @override
  List<Object> get props => [_user];
}

class ErrorState extends AuthState {
  final message;

  ErrorState(this.message);

   @override
  List<Object> get props => [];

}
