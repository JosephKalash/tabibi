import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/doctors/data/models/doctor_model.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';

abstract class DoctorDS {
  Future<List<Doctor>> getDoctor();
}

class DoctorDSImpl extends DoctorDS {
  final Dio _dio;
  final SharedPreferences _preferences;

  DoctorDSImpl(this._dio, this._preferences);

  @override
  Future<List<Doctor>> getDoctor() async {
    final token = _preferences.getString(kTokenKey);

    final response = await _dio.get(
      DOCTORS_URL,
      queryParameters: {kKey: token},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      if (data[kDoctorsList] == null) throw ServerException();
      final list = data[kDoctorsList] as List<dynamic>;
      final doctors = list.map((e) => DoctorModel.fromJson(e)).toList();
      return doctors;
    } else
      throw HttpException(kDoctorErrorMessage);
  }
}
