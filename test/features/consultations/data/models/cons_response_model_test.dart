import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/cons_response_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final consResponse = ConsResponseModel(
    'respo',
    'doc',
    DateTime.parse('2020-11-11'),
  );
  test(
    'should parse json object',
    () async {
      //arrange
      final map = json.decode(getJson('consResponse.json'));
      //act
      final result = ConsResponseModel.fromJson(map);
      //assert
      expect(result, consResponse);
    },
  );
  test(
    'should convert to json',
    () async {
      //arrange
      final map = json.decode(getJson('consResponse.json'));
      //act
      final result = consResponse.toJson();
      //assert
      map[kResponseDate] = '${map[kResponseDate]}T00:00:00.000';
      expect(result, map);
    },
  );
}
