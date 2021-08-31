import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';
import 'package:tabibi/features/authentication/domain/usecases/auto_login.dart';
import 'package:tabibi/features/authentication/domain/usecases/login.dart';
import 'package:tabibi/features/authentication/domain/usecases/logout.dart';
import 'package:tabibi/features/authentication/domain/usecases/signin.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart';

import 'auth_cubit_test.mocks.dart';

@GenerateMocks([Logout, Login, Signin, AutoLogin])
void main() {
  final login = MockLogin();
  final logout = MockLogout();
  final signin = MockSignin();
  final autoLogin = MockAutoLogin();
  final cubit = AuthCubit(login, logout, signin,autoLogin);
  group(
    'signin',
    () {
      final username = 'joseph';
      final password = 'password';
      final user = User(
        '_token',
      );
      test(
        'should emits Loading then Error states when signin fails with ServerFailure',
        () async {
          //arrange
          when(signin(any, any)).thenAnswer((_) async => Left(ServerFailure()));
          //assert
          final expected = [
            LoadingState(),
            ErrorState('خطأ بالاتصال بالمخدم!'),
          ];
          expectLater(cubit.stream, emitsInOrder(expected));
          //act
          cubit.signinUser(username, password);
          verify(signin(username, password));
        },
      );

      test(
        'should emits Loading then authenticated states when signin success\'',
        () async {
          //arrange
          when(signin(any, any)).thenAnswer((_) async => Right(user));
          //assert
          final expected = [
            LoadingState(),
            AuthenticatedState(user),
          ];
          expectLater(cubit.stream, emitsInOrder(expected));
          //act
          cubit.signinUser(username, password);
        },
      );
    },
  );
}
