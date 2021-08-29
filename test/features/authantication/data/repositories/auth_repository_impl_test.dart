import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/core/network/internet_info.dart';
import 'package:tabibi/features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'package:tabibi/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';

import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([InternetInfo, AuthRemoteDataSource])
void main() {
  final remoteDS = MockAuthRemoteDataSource();
  final internetInfo = MockInternetInfo();
  final repo = AuthRepoImpl(internetInfo, remoteDS);
  final username = 'joseph';
  final password = '123546';

  final user = User('_token');

  void setUpOnline() {
    when(internetInfo.isConnect).thenAnswer((_) async => true);
  }

  group(
    'sgininUser',
    () {
      test(
        'should call internet isConnect when signin has called',
        () async {
          //arrange
          setUpOnline();
          when(remoteDS.signinUser(any, any)).thenAnswer((_) async => user);
          //act
          await repo.signin(username, password);
          //assert
          verify(internetInfo.isConnect);
        },
      );

      group(
        'there is internet',
        () {
          setUp(() {
            setUpOnline();
          });
          test(
            'should call return user from remote data source when sgininUser success',
            () async {
              //arrange
              when(remoteDS.signinUser(any, any)).thenAnswer((_) async => user);
              //act
              final result = await repo.signin(username, password);
              //assert
              expect(result, Right(user));
            },
          );
          test(
            'should return ServerFailure when sgininUser fails',
            () async {
              //arrange
              when(remoteDS.signinUser(any, any)).thenThrow(ServerException());
              //act
              final result = await repo.signin(username, password);
              //assert
              expect(result, Left(ServerFailure()));
            },
          );
        },
      );
      group(
        'offline',
        () {
          setUp(() {
            when(internetInfo.isConnect).thenAnswer((_) async => false);
          });
          test(
            'should return InterentFailure when there is no internet',
            () async {
              //act
              final result = await repo.signin(username, password);
              //assert
              expect(result, Left(InternetFailure()));
            },
          );
        },
      );
    },
  );
}
