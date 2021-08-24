import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/authentication/data/models/user_model.dart';

import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> signinUser(String username, String password);
  Future<User> loginUser(String username, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;
  final SharedPreferences _sharedPreferences;

  AuthRemoteDataSourceImpl(this.dio, this._sharedPreferences);

  @override
  Future<User> signinUser(String username, String password) async {
    return _authanticeUser(username, password, SIGNUP_URL);
  }

  Future<User> _authanticeUser(
    String username,
    String password,
    String url,
  ) async {
    final result = await dio.post(
      url,
      data: {kUsername: username, kPassword: password},
    );
    
    final data = result.data;
    if (result.statusCode == 200) {
      final user = UserModel.fromJson(data);

      await _sharedPreferences.setString(kTokenKey, user.token);

      return user;
    }
    throw HttpException(data['message']);
  }

  @override
  Future<User> loginUser(String username, String password) async {
    return _authanticeUser(username, password, LOGIN_URL);
  }
}
