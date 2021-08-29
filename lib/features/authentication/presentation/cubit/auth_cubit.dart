import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/funcs.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/auto_login.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/signin.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login _login;
  final Logout _logout;
  final Signin _signin;
  final AutoLogin _autoLogin;

  AuthCubit(
    this._login,
    this._logout,
    this._signin,
    this._autoLogin,
  ) : super(AuthInitial());

  Future<void> logoutUser()async {
    emit(LoadingState());
    await _logout();
    emit(LogoutState(true));
  }

  Future<void> tryLoginUser() async {
    emit(LoadingState());

    final isLogin =await _autoLogin();
    if (isLogin)
      emit(AuthenticatedState(User('sdf3lk3klj3')));
    else 
      emit(LogoutState(true));
  }

  Future<void> signinUser(String username, String password) async {
    await _authantic(username, password, () => _signin(username, password));
  }

  Future<void> loginUser(String username, String password) async {
    await _authantic(username, password, () => _login(username, password));
  }

  Future<void> _authantic(
    String username,
    String password,
    Function call,
  ) async {
    emit(LoadingState());

    final either = await call();
    either.fold(
      (error) async {
        final errorMessage = getErrorMessage(error);
        emit(ErrorState(errorMessage));
      },
      (user) => emit(AuthenticatedState(user)),
    );
  }
}
