import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';
import 'package:tabibi/features/authentication/domain/usecases/login.dart';
import 'package:tabibi/features/authentication/domain/usecases/logout.dart';
import 'package:tabibi/features/authentication/domain/usecases/signin.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login _login;
  final Logout _logout;
  final Signin _signin;

  AuthCubit(
    this._login,
    this._logout,
    this._signin,
  ) : super(AuthInitial());

  void logoutUser(User user) {
    _logout(user);
    emit(LogoutState(user));
  }

  Future<void> siginUser(String username, String password) async {
    await _authantic(username, password, () => _signin(username, password));
  }

  Future<void> loginUser(String username, String password) async {
    await _authantic(username, password, () => _login(username, password));
  }

  Future _authantic(String username, String password, Function call) async {
    emit(LoadingState());

    final either = await call();
    either.fold(
      (error) async {
        final errorMessage;
        if (error is ServerFailure)
          errorMessage = 'An error occurred on server!';
        else if (error is InternetFailure)
          errorMessage = 'There is no Internet connection!';
        else if (error is HttpFailure)
          errorMessage = error.message;
        else
          errorMessage = 'Unknown error occurred... try again later';
        emit(ErrorState(errorMessage));
      },
      (user) => emit(AuthenticatedState(user)),
    );
  }
}
