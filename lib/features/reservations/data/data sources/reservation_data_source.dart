import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/reservations/data/models/reservation_model.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

abstract class ReservationDS {
  Future<bool> addReservation(Reservation reservation);
  Future<List<Reservation>> getReservations();
  Future<bool> cancelReservation(Reservation reservation);
}

class ReservationDSImpl extends ReservationDS {
  final Dio _dio;
  final SharedPreferences _preferences;

  ReservationDSImpl(this._dio, this._preferences);

  @override
  Future<bool> addReservation(Reservation reservation) async {
    final reservModel = ReservationModel.fromParent(reservation);

    final token = _preferences.getString(kTokenKey);

    _dio.options.headers[kAuthorization] = '$kBearer$token';
    final response = await _dio.post(
      ADD_RESERVATION_URL,
      data: reservModel.toJson(),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else
      throw HttpException(kReservationAddErrorMessage);
  }

  @override
  Future<bool> cancelReservation(Reservation reservation) async {
    final token = _preferences.getString(kTokenKey);

    _dio.options.headers[kAuthorization] = '$kBearer$token';
    final response = await _dio.delete(
      '$CANCEL_RESERVATION_URL${reservation.id}',
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else
      throw HttpException(kReservationCancelErrorMessage);
  }

  @override
  Future<List<Reservation>> getReservations() async {
    final token = _preferences.getString(kTokenKey);

    _dio.options.headers[kAuthorization] = '$kBearer$token';
    final response = await _dio.get(GET_RESERVATION_URL);

    if (response.statusCode == 200) {
      final reservations = response.data as List<dynamic>;
      final list = reservations
          .map(
            (e) => ReservationModel.fromJson(e),
          )
          .toList();
      return list;
    } else
      throw HttpException(kGetReservError);
  }
}
