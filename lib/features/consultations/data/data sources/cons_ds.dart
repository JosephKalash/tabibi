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
  final Dio _dio;
  final SharedPreferences _sharedPreferences;

  ConsultationDSImpl(this._dio, this._sharedPreferences);

  @override
  Future<bool> addConsultation(Consultation consultation) async {
    final consModel = ConsultationModel.fromParent(consultation);

    final token = _sharedPreferences.getString(kTokenKey);

    _dio.options.headers[kAuthorization] = '$kBearer$token';
    final response = await _dio.post(
      ADD_CONSUL_URL,
      data: consModel.toJson(),
    );
    if (response.statusCode == 200)
      return true;
    else
      throw HttpFailure(kAddConsErrorMessage);
  }

  @override
  Future<List<Consultation>> getConsultations() async {
    //final token = _sharedPreferences.getString(kTokenKey);
    //_dio.options.headers[kAuthorization] = '$kBearer$token';

    final response = await _dio.get(GET_CONSULS_URL);

    if (response.statusCode == 200) {
      final list = response.data as List<dynamic>;
      final cons = list.map((e) => ConsultationModel.fromJson(e)).toList();
      return cons;
    } else
      throw HttpFailure(kGetConsError);
  }

  @override
  Future<List<Consultation>> getConsultationsBySpeci(String specialization) {
    throw UnimplementedError();
  }

  @override
  Future<List<Consultation>> getMyConsultations(String userId) async{
     final token = _sharedPreferences.getString(kTokenKey);

    _dio.options.headers[kAuthorization] = '$kBearer$token';
    final response = await _dio.get(GET_CONSULS_URL);

    if (response.statusCode == 200) {
      final list = response.data as List<dynamic>;
      final cons = list.map((e) => ConsultationModel.fromJson(e)).toList();
      return cons;
    } else
      throw HttpFailure(kGetConsError);
  }
}
