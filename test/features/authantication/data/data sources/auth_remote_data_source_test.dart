import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tabibi/features/authentication/data/data%20sources/auth_remote_data_source.dart';

import 'auth_remote_DS_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();
  final remoteDS = AuthRemoteDataSourceImpl(dio);

  group(
    'sgininUser',
    () {
      test(
      'should make request to server with proper info',
      ()async {
      //arrange
      
      //act
      
      //assert
      
      },
      );
    },
  );
}
