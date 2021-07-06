import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/features/consultations/data/data%20sources/cons_ds.dart';
import 'package:tabibi/features/consultations/data/repositories/consultation_repo.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

import '../../../authantication/data/repositories/auth_repository_impl_test.mocks.dart';
import 'consultation_repo_test.mocks.dart';

@GenerateMocks([ConsultationDS])
void main() {
  final mockConsDS = MockConsultationDS();
  final mockInternet = MockInternetInfo();
  final consultationRepo = ConsultationRepoImpl(mockConsDS, mockInternet);

  final date = DateTime.now();

  void _setupInternetSuccess() =>
      when(mockInternet.isConnect).thenAnswer((_) async => true);

  void _setupInternetFail() =>
      when(mockInternet.isConnect).thenAnswer((_) async => false);
  group(
    'add consultation',
    () {
      final consultation =
          Consultation('clinicSpecialization', 'title', 'content', date);

      test(
        'should call internet checker to check internet connection',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.addConsultation(any)).thenAnswer((_) async => true);

          //act
          consultationRepo.addConsultation(consultation);
          //assert
          verify(mockInternet.isConnect);
        },
      );
      test(
        'should return true when calling consultationDS.addConsultation return true ',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.addConsultation(any)).thenAnswer((_) async => true);
          //act
          final result = await consultationRepo.addConsultation(consultation);
          //assert
          verify(mockConsDS.addConsultation(consultation));
          expect(result, true);
        },
      );
    },
  );
  group(
    'get consultations',
    () {
      final cons = [
        Consultation(
          'clinicSpecialization',
          'title',
          'content',
          date,
        )
      ];
      test(
        'should call internet checker to check internet connection',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getConsultations()).thenAnswer((_) async => cons);

          //act
          consultationRepo.getCons();
          //assert
          verify(mockInternet.isConnect);
        },
      );
      test(
        'should return consultations list when call getCons',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getConsultations()).thenAnswer((_) async => cons);
          //act
          final result = await consultationRepo.getCons();
          //assert
          expect(result, Right(cons));
        },
      );
      test(
        'should return HttpFailure when getCons throw HttpException',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getConsultations())
              .thenThrow(HttpException('message'));
          //act
          final result = await consultationRepo.getCons();
          //assert
          expect(result, Left(HttpFailure('message')));
        },
      );
      test(
        'should return InternetFailure for offline condition',
        () async {
          //arrange
          _setupInternetFail();
          //act
          final result = await consultationRepo.getCons();
          //assert
          expect(result, Left(InternetFailure()));
        },
      );
    },
  );
  group(
    'get consultations by specialization',
    () {
      final specialization = 'hi';
      final cons = [
        Consultation(
          'clinicSpecialization',
          'title',
          'content',
          date,
        )
      ];
      test(
        'should call internet checker to check internet connection',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getConsultationsBySpeci(any))
              .thenAnswer((_) async => cons);
          //act
          consultationRepo.getConsBySpeci(specialization);
          //assert
          verify(mockInternet.isConnect);
        },
      );
      test(
        'should return consultations list when call getConsBySpeci',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getConsultationsBySpeci(any))
              .thenAnswer((_) async => cons);
          //act
          final result = await consultationRepo.getConsBySpeci(specialization);
          //assert
          expect(result, Right(cons));
        },
      );
      test(
        'should return HttpFailure when getConsBySpeci throw HttpException',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getConsultationsBySpeci(any))
              .thenThrow(HttpException('message'));
          //act
          final result = await consultationRepo.getConsBySpeci(specialization);
          //assert
          expect(result, Left(HttpFailure('message')));
        },
      );
      test(
        'should return InternetFailure for offline condition',
        () async {
          //arrange
          _setupInternetFail();
          //act
          final result = await consultationRepo.getConsBySpeci(specialization);
          //assert
          expect(result, Left(InternetFailure()));
        },
      );
    },
  );
    group(
    'get my consultations',
    () {
      final userId = 'hi';
      final cons = [
        Consultation(
          'clinicSpecialization',
          'title',
          'content',
          date,
        )
      ];
      test(
        'should call internet checker to check internet connection',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getMyConsultatioins(userId))
              .thenAnswer((_) async => cons);
          //act
          consultationRepo.getMyCons(userId);
          //assert
          verify(mockInternet.isConnect);
        },
      );
      test(
        'should return consultations list when call getMyCons',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getMyConsultatioins(any))
              .thenAnswer((_) async => cons);
          //act
          final result = await consultationRepo.getMyCons(userId);
          //assert
          expect(result, Right(cons));
        },
      );
      test(
        'should return HttpFailure when getmyCons throw HttpException',
        () async {
          //arrange
          _setupInternetSuccess();
          when(mockConsDS.getMyConsultatioins(any))
              .thenThrow(HttpException('message'));
          //act
          final result = await consultationRepo.getMyCons(userId);
          //assert
          expect(result, Left(HttpFailure('message')));
        },
      );
      test(
        'should return InternetFailure for offline condition',
        () async {
          //arrange
          _setupInternetFail();
          //act
          final result = await consultationRepo.getMyCons(userId);
          //assert
          expect(result, Left(InternetFailure()));
        },
      );
    },
  );
}
