import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/excpetions.dart';
import '../../../../core/utils/constaints.dart';
import '../../domain/entities/doctor.dart';
import '../models/doctor_model.dart';

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

    _dio.options.headers[kAuthorization] = '$kBearer$token';
    final response = await _dio.get(DOCTORS_URL);

    if (response.statusCode == 200) {
      final list = response.data as List<dynamic>;

      final doctors = list.map((e) => DoctorModel.fromJson(e)).toList();

      return doctors;
    } else
      throw HttpException(kDoctorErrorMessage);
  }
}
