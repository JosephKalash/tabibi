import 'package:dio/dio.dart';

import '../../../../core/error/excpetions.dart';
import '../../../../core/utils/constaints.dart';
import '../../domain/entities/specialization.dart';
import '../models/specialization_model.dart';

abstract class SpecializationDS {
  Future<List<Specialization>> getSpecializations();
}

class SpecialztionDSImpl extends SpecializationDS {
  final Dio _dio;

  SpecialztionDSImpl(this._dio);

  @override
  Future<List<Specialization>> getSpecializations() async {
    final response = await _dio.get(SPECIALIZATION_URL);

    if (response.statusCode == 200) {
      final list = response.data as List<dynamic>;
      final specis = list.map((e) => SpecializationModel.fromJson(e)).toList();
      return specis;
    } else
      throw HttpException('خطأ اثناء الاتصال بالمخدم');
  }
}
