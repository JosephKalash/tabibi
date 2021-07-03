import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'package:tabibi/features/authentication/data/models/user_model.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';

import 'auth_remote_DS_test.mocks.dart';

@GenerateMocks([dio.Dio])
void main() {
  final mockDio = MockDio();
  final remoteDS = AuthRemoteDataSourceImpl(mockDio);

  final username = 'joseph';
  final password = 'password';

  final response = {
    kLocalIdKey: '123',
    kTokenKey: '123',
  };

  final user = UserModel('123', '123', null);

  _setupDioPostSuccess() {
    when(mockDio.post(
      any,
      data: anyNamed('data'),
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer(
      (_) async => dio.Response(
        data: response,
        statusCode: 200,
        requestOptions: dio.RequestOptions(path: ''),
      ),
    );
  }

  _setupDioPostFail() {
    when(mockDio.post(
      any,
      data: anyNamed('data'),
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer(
      (_) async => dio.Response(
        data: {'message': 'error'},
        statusCode: 400,
        requestOptions: dio.RequestOptions(path: ''),
      ),
    );
  }

  group(
    'sgininUser',
    () {
      test(
        'should make request to server with proper info',
        () async {
          //arrange
          _setupDioPostSuccess();
          //act
          remoteDS.signinUser(username, password);
          //assert
          verify(
            mockDio.post(
              SIGNUP_URL,
              queryParameters: {
                'key': 'test',
              },
              data: {
                kUsername: username,
                kPassword: password,
              },
            ),
          );
        },
      );
      test(
        'should return User object when request succeeded',
        () async {
          //arrange
          _setupDioPostSuccess();
          //act
          final result = await remoteDS.signinUser(username, password);
          //assert
          expect(result, isA<User>());
          expect(result, user);
        },
      );
      test(
        'should throw httpExeption when request failed',
        () async {
          //arrange
          _setupDioPostFail();
          //act
          final call = remoteDS.signinUser;
          //assert
          expect(()=> call(username,password), throwsA(isInstanceOf<HttpException>()));
        },
      );
    },
  );
}
