import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

abstract class ConsultationDS {
  Future<bool> addConsultation(Consultation consultation);
  Future<List<Consultation>> getConsultations();
  Future<List<Consultation>> getMyConsultations(String userId);
  Future<List<Consultation>> getConsultationsBySpeci(String specialization);
}

class ConsultationDSImpl extends ConsultationDS {
  final Dio dio;
  final SharedPreferences _sharedPreferences;

  ConsultationDSImpl(this.dio, this._sharedPreferences);

  @override
  Future<bool> addConsultation(Consultation consultation) async {
    final consModel = ConsultationModel.fromParent(consultation);

    final token = _sharedPreferences.getString(kTokenKey);

    final response = await dio.post(
      ADD_CONSUL_URL,
      queryParameters: {kKey: token},
      data: consModel.toJson(),
    );
    final data = response.data;
    if (response.statusCode == 200) {
      if (data[kAddConsRspo] == null) throw ServerFailure();
      final isSuccess = data[kAddConsRspo];
      return isSuccess;
    } else
      throw HttpFailure(kAddConsErrorMessage);
  }

  @override
  Future<List<Consultation>> getConsultations() async {
    final token = _sharedPreferences.getString(kTokenKey);

    final response = await dio.get(
      GET_CONSULS_URL,
      queryParameters: {kKey: token},
    );
    final data = response.data;
    if (response.statusCode == 200) {
      return [];
    } else
      throw HttpFailure(data[kJsonErrorKey]);
  }

  @override
  Future<List<Consultation>> getConsultationsBySpeci(String specialization) {
    throw UnimplementedError();
  }

  @override
  Future<List<Consultation>> getMyConsultations(String userId) {
    throw ServerException();
  }
}
