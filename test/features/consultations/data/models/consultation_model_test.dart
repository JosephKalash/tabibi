import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final consultation = ConsultationModel(
    'clinic',
    'title',
    'content',
    DateTime.parse('2020-10-10'),
  );
  test(
    'should parse json object',
    () async {
      //arrange
      final map = json.decode(getJson('consultation.json'));
      //act
      final result = ConsultationModel.fromJson(map);
      //assert
      expect(result, consultation);
    },
  );
  test(
    'should convert to json',
    () async {
      //arrange
      final map = json.decode(getJson('ConsultationPure.json'));
      //act
      final result = consultation.toJson();
      //assert
      map[kConsDate] = '${map[kConsDate]}T00:00:00.000';
      expect(result, map);
    },
  );
}
