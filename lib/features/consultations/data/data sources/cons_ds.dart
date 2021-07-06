import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

abstract class ConsultationDS {
  Future<bool> addConsultation(Consultation consultation);
  Future<List<Consultation>> getConsultations();
  Future<List<Consultation>> getMyConsultatioins(String userId);
  Future<List<Consultation>> getConsultationsBySpeci(String specialization);
}

class ConsultationDSImpl extends ConsultationDS {
  final Dio dio;
  final SharedPreferences _sharedPreferences;

  ConsultationDSImpl(this.dio, this._sharedPreferences);

  Map<String, dynamic> _getAuthFromPref() =>
      json.decode(_sharedPreferences.getString(kauthPref) ?? '');

  @override
  Future<bool> addConsultation(Consultation consultation) async {
    final consModel = ConsultationModel.fromParent(consultation);

    final map = _getAuthFromPref();

    final response = await dio.post(
      '$ADD_CONSUL_URL/${map[kUserIdKey]}',
      queryParameters: {kKey: map[kTokenKey]},
      data: consModel.toJson(),
    );
    final data = response.data;
    if (response.statusCode == 200) {
      if (data[kAddConsRspo] == null) return false;
      final isSuccess = data[kAddConsRspo];
      return isSuccess;
    } else
      return false;
  }

  @override
  Future<List<Consultation>> getConsultations() async {
    final map = _getAuthFromPref();

    final response = await dio.get(
      GET_CONSULS_URL,
      queryParameters: {kKey: map[kTokenKey]},
    );
    final data = response.data;
    if (response.statusCode == 200) {
      return [];
    } else
      return [];
  }

  @override
  Future<List<Consultation>> getConsultationsBySpeci(String specialization) {
    throw UnimplementedError();
  }

  @override
  Future<List<Consultation>> getMyConsultatioins(String userId) {
    throw UnimplementedError();
  }
}
