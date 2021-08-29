import 'package:dio/dio.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/specializations/data/models/specialization_model.dart';
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
      final list = response.data as List<dynamic>;
      final specis = list.map((e) => SpecializationModel.fromJson(e)).toList();
      return specis;
    } else
      throw HttpException('خطأ اثناء الاتصال بالمخدم');
  }
}
