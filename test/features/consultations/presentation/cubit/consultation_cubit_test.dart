import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';
import 'package:tabibi/features/consultations/domain/usecasese/add_cons.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_cons.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_cons_bySpeci.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_my_cons.dart';
import 'package:tabibi/features/consultations/presentation/cubit/consultation_cubit.dart';

import 'consultation_cubit_test.mocks.dart';

@GenerateMocks([GetCons, GetMyCons, AddCons, GetConsBySpeci])
void main() {
  final getCons = MockGetCons();
  final addCons = MockAddCons();
  final getMyCons = MockGetMyCons();
  final getConsBySpeci = MockGetConsBySpeci();

  final consCubit = ConsultationCubit(
    addCons,
    getCons,
    getMyCons,
    getConsBySpeci,
  );

  final date = DateTime.now();
  group(
    'add consultation',
    () {
      final cons = ConsultationModel(
        'clinicSpecialization',
        'title',
        'content',
        date,
      );
      test(
        'should emit AddedConsultation if adding succeed',
        () async {
          //arrange
          when(addCons(any)).thenAnswer((_) async => true);
          //assert
          final expected = [
            Loading(),
            AddedConsultation(),
          ];
          expectLater(consCubit.stream, emitsInOrder(expected));
          //act
          consCubit.addConsultation(cons);
          verify(addCons(cons));
        },
      );
      test(
        'should emit ErrorState if adding failed',
        () async {
          //arrange
          when(addCons(any)).thenAnswer((_) async => false);
          //assert
          final expected = [
            Loading(),
            ErrorState(kAddConsErrorMessage),
          ];
          expectLater(consCubit.stream, emitsInOrder(expected));
          //act
          consCubit.addConsultation(cons);
        },
      );
    },
  );
  group(
    'get consultations',
    () {
      final cons = [
        ConsultationModel(
          'clinicSpecialization',
          'title',
          'content',
          date,
        )
      ];
      test(
        'should emit getConsultations when success',
        () async {
          //arrange
          when(getCons()).thenAnswer((_) async => Right(cons));
          //assert
          final expected = [
            Loading(),
            GotConsultations(cons),
          ];
          expectLater(consCubit.stream, emitsInOrder(expected));
          //act
          consCubit.getConsultations();
        },
      );
      test(
        'should emit Error when HttpFailure was returned',
        () async {
          //arrange
          when(getCons()).thenAnswer((_) async => Left(HttpFailure('message')));
          //assert
          final expected = [
            Loading(),
            ErrorState('message'),
          ];
          expectLater(consCubit.stream, emitsInOrder(expected));
          //act
          consCubit.getConsultations();
        },
      );
    },
  );
  group(
    'get my consultations',
    () {
      final cons = [
        ConsultationModel(
          'clinicSpecialization',
          'title',
          'content',
          date,
        )
      ];
      final userId = 'joseph';
      test(
        'should emit getMyConsultations when success',
        () async {
          //arrange
          when(getMyCons(any)).thenAnswer((_) async => Right(cons));
          //assert
          final expected = [
            Loading(),
            GotMyConsultations(cons),
          ];
          expectLater(consCubit.stream, emitsInOrder(expected));
          //act
          consCubit.getMyConsultation(userId);
          verify(getMyCons(userId));
        },
      );
      test(
        'should emit Error when HttpFailure was returned',
        () async {
          //arrange
          when(getMyCons(any))
              .thenAnswer((_) async => Left(HttpFailure('message')));
          //assert
          final expected = [
            Loading(),
            ErrorState('message'),
          ];
          expectLater(consCubit.stream, emitsInOrder(expected));
          //act
          consCubit.getMyConsultation(userId);
        },
      );
    },
  );
}
