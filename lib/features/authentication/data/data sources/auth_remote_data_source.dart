import 'package:dio/dio.dart';

import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> signinUser(String username, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<User> signinUser(String username, String password) {
    final auth_url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=';

    final result = dio.post(auth_url, data: {
      'test': 'test',
    });

    throw UnimplementedError();
  }
}
