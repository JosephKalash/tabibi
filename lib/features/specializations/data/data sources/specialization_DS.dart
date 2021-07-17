import 'package:dio/dio.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/specializations/domain/entities/specialization.dart';

abstract class SpecializationDS {
  Future<List<Specialization>> getSpecializations();
}

class SpecialztionDSImpl extends SpecializationDS {
  final Dio dio;

  SpecialztionDSImpl(this.dio);

  @override
  Future<List<Specialization>> getSpecializations() async {
    final response = await dio.get(SPECIALIZATION_URL);
    if (response.statusCode == 200) {
      final data = response.data;
      final list = data['list'] as List<dynamic>;
      return [];
    } else
      throw HttpException('خطأ اثناء الاتصال بالمخدم');
  }
}
