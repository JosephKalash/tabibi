part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {
  @override
  List<Object> get props => ['loading'];
}

class AuthenticatedState extends AuthState {
  final User user;

  AuthenticatedState(this.user);

  @override
  List<Object> get props => [user];
}

class LogoutState extends AuthState {
  final isSuccess;

  LogoutState(this.isSuccess);

  @override
  List<Object> get props => [isSuccess];
}

class ErrorState extends AuthState {
  final message;

  ErrorState(this.message);

  @override
  List<Object> get props => [this.message];
}
