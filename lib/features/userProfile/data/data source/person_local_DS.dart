import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/constaints.dart';
import '../../domain/entities/person.dart';
import '../models/person_model.dart';

abstract class PersonLocalDS {
  Person? getPersonInfoFromLocal();
}

class PersonLocalDSImpl extends PersonLocalDS {
  final SharedPreferences _sharedPreferences;
  final Dio _dio;

  PersonLocalDSImpl(this._sharedPreferences, this._dio);

  @override
  Person? getPersonInfoFromLocal() {
    if (!_sharedPreferences.containsKey(kPersonInfoPref)) return null;

    final jsonData = _sharedPreferences.getString(kPersonInfoPref);
    if (jsonData == null) return null;
    
    final map = json.decode(jsonData);

    //   final token = _sharedPreferences.getString(kTokenKey);
    //   _dio.options.headers[kAuthorization] = '$kBearer$token';
    //  _dio
    //       .post(
    //         LOGIN_URL,
    //         data: map,
    //       )
    //       .catchError((_) {});

    return PersonModel.fromJson(map);
  }
}
