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

  PersonLocalDSImpl(this._sharedPreferences);

  @override
  Person? getPersonInfoFromLocal() {
    final jsonData = _sharedPreferences.getString(kPersonInfoPref);
    if (jsonData == null) return null;
    final map = json.decode(jsonData);

    final token = _sharedPreferences.getString(kTokenKey);
    final dio = Dio();
    dio
        .post(
          LOGIN_URL,
          queryParameters: {kKey: token},
          data: map,
        )
        .catchError((_) {});

    return PersonModel.fromJson(map);
  }
}
