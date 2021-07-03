import 'dart:io';

String getJson(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();
