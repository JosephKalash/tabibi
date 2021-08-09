import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/reservations/data/models/reservation_model.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

abstract class ReservationDS {
  Future<bool> addReservation(Reservation reservation);
  Future<List<Reservation>> getReservation();
  Future<bool> cancelReservation(Reservation reservation);
}

class ReservationDSImpl extends ReservationDS {
  final Dio _dio;
  final SharedPreferences _preferences;

  ReservationDSImpl(this._dio, this._preferences);

  Map<String, dynamic> _getAuthFromPref() =>
      json.decode(_preferences.getString(kauthPref) ?? '');

  @override
  Future<bool> addReservation(Reservation reservation) async {
    final reservModel = ReservationModel.fromParent(reservation);

    final map = _getAuthFromPref();

    final response = await _dio.post(
      '$ADD_RESERVATION_URL/${map[kUserIdKey]}',
      queryParameters: {kKey: map[kTokenKey]},
      data: reservModel.toJson(),
    );
    if (response.statusCode == 200) {
      final data = response.data;
      if (data[kAddReservRespo] == null) throw ServerException();
      final isSuccess = data[kAddConsRspo];
      if (isSuccess) return true;
      return false;
    } else
      throw HttpException(kReservationErrorMessage);
  }

  @override
  Future<bool> cancelReservation(Reservation reservation) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Reservation>> getReservation() async {
    final map = _getAuthFromPref();

    final response = await _dio.get(
      GET_RESERVATION_URL,
      queryParameters: {kKey: map[kTokenKey]},
    );
    if (response.statusCode == 200) {
      final data = response.data;
      if (data[kGetReservRespo] == null) throw ServerException();
      final reservations = data[kAddConsRspo] as List<dynamic>;
      final list = reservations
          .map((e) => ReservationModel.fromJson(e))
          .toList();
      return list;
    } else
      throw HttpException(kGetReservError);
  }
}
