import 'package:flutter_test/flutter_test.dart';
import 'package:tabibi/features/authentication/data/models/user_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'dart:convert';

void main() {
  final user = UserModel( '123');

  test(
    'should decode json object correctly',
    () async {
      //arrange
      final jsonData = json.decode(getJson('auth.json'));
      //act
      final result = UserModel.fromJson(jsonData);
      //assert
      expect(result, user);
    },
  );
  test(
    'should encode json object correctly',
    () async {
      //arrange
      final mapData = user.toJson();
      final expected = json.decode(getJson('auth2.json'));
      //assert
      expect(expected, mapData);
    },
  );
}
