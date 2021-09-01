import 'dart:convert';

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
    if (!_sharedPreferences.containsKey(kPersonInfoPref)) return null;

    final jsonData = _sharedPreferences.getString(kPersonInfoPref);
    if (jsonData == null) return null;
    
    final map = json.decode(jsonData);

    return PersonModel.fromJson(map);
  }
}
