import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/authentication/data/models/user_model.dart';

import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User> signinUser(String username, String password);
  Future<User> loginUser(String username, String password);
  bool tryAutoLoginUser();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;
  final SharedPreferences _sharedPreferences;

  AuthRemoteDataSourceImpl(this.dio, this._sharedPreferences);

  @override
  Future<User> signinUser(String username, String password) async {
    return _makeAuthantication(username, password, SIGNUP_URL);
  }

  Future<User> _makeAuthantication(
    String username,
    String password,
    String url,
  ) async {
    final response = await dio.post(
      url,
      data: {
        kUserName: 'Rayan',
        kUserPhoneNumber: '092221124',
        kUserAge: 20,
        kUserEmail: username,
        kPassword: password,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = response.data;
      if (data[kTokenKey] != null) {
        final user = UserModel.fromJson(data);
        await _sharedPreferences.setString(kTokenKey, user.token);
        return user;
      } else
        return User('token');
    }
    throw HttpException('خطأ اثناء تسجيل الدخول');
  }

  @override
  Future<User> loginUser(String username, String password) async {
    return _makeAuthantication(username, password, LOGIN_URL);
  }

  @override
  bool tryAutoLoginUser() {
    if (!_sharedPreferences.containsKey(kTokenKey)) return false;

    final token = _sharedPreferences.getString(kTokenKey);
    if (token == null) return false;
    return true;
  }
}
