import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/data%20sources/cons_ds.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';
import '../../../authantication/data/data sources/auth_remote_DS_test.mocks.dart';
import 'cons_ds_test.mocks.dart';

void main() {
  final dio = MockDio();
  final mockShard = MockSharedPreferences();
  final consultationDS = ConsultationDSImpl(dio, mockShard);
  final date = DateTime.now();
  void _setupPreferences() {
    when(mockShard.getString(any)).thenReturn(json.encode({
      kTokenKey: 'test',
      kUserIdKey: 'test',
    }));
  }

  group(
    'add consultation',
    () {
      _setupDioPostReq() {
        when(dio.post(
          any,
          queryParameters: anyNamed('queryParameters'),
          data: anyNamed('data'),
        )).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            data: {kAddConsRspo: true},
            requestOptions: RequestOptions(path: ''),
          ),
        );
      }

      final consultation = ConsultationModel(
        'clinicSpecialization',
        'title',
        'content',
        date,
      );
      test(
        'should send post request with proper paramters',
        () async {
          _setupDioPostReq();
          _setupPreferences();
          //act
          consultationDS.addConsultation(consultation);
          //assert
          verify(dio.post(
            '$ADD_CONSUL_URL/test',
            queryParameters: {kKey: 'test'},
            data: consultation.toJson(),
          ));
        },
      );
    },
  );
  group(
    'get Consultations',
    () {
      final cons = [
        ConsultationModel(
          'clinicSpecialization',
          'title',
          'content',
          date,
        )
      ];
      _setupDioGetReq() {
        when(dio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
        )).thenAnswer(
          (_) async => Response(
              statusCode: 200,
              data: cons,
              requestOptions: RequestOptions(path: '')),
        );
      }

      test(
        'should make get request with proper params',
        () async {
          //arrange
          _setupDioGetReq();
          _setupPreferences();
          //act
          consultationDS.getConsultations();
          //assert
          verify(dio.get(GET_CONSULS_URL, queryParameters: {kKey: 'test'}));
        },
      );
      test(
        'should get consultations list when make get request',
        () async {
          //arrange
          _setupDioGetReq();
          _setupPreferences();
          //act
          final result = await consultationDS.getConsultations();
          //assert
          expect(result, cons);
        },
      );
    },
  );
}
