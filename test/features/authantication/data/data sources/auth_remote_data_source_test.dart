import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'package:tabibi/features/authentication/data/models/user_model.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';

import '../../../consultations/data/data source/cons_ds_test.mocks.dart';
import 'auth_remote_DS_test.mocks.dart';

@GenerateMocks([dio.Dio])
void main() {
  final mockDio = MockDio();
  final mockShared = MockSharedPreferences();
  final remoteDS = AuthRemoteDataSourceImpl(mockDio, mockShared);

  final username = 'joseph';
  final password = 'password';

  final response = {
    kTokenKey: '123',
  };

  final user = UserModel('123');

  _setupDioPostSuccess() {
    when(mockDio.post(
      any,
      data: anyNamed('data'),
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
          when(mockShared.setString(any, any)).thenAnswer((_) async => true);
          //act
          remoteDS.signinUser(username, password);
          //assert
          verify(
            mockDio.post(
              SIGNUP_URL,
              data: {
                'full_name': 'Rayan',
                'phone_number': '092221124',
                'age': 20,
                kUserEmail: username,
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
          when(mockShared.setString(any, any)).thenAnswer((_) async => true);

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
          expect(() => call(username, password),
              throwsA(isInstanceOf<HttpException>()));
        },
      );
    },
  );
}
