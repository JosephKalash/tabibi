import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_my_cons.dart';

import 'add_cons_test.mocks.dart';

void main() {
  final mockRepo = MockConsultationRepo();
  final getMyCons = GetMyCons(mockRepo);

  final date = DateTime.now();

  final list = [
    Consultation(
      'clinicSpecialization',
      'title',
      'content',
      date,
    )
  ];
  final userId = 'hi';
  test(
    'should return list of cons',
    () async {
      //arrange
      when(mockRepo.getMyCons(any)).thenAnswer((_) async => Right(list));
      //act
      final result = await getMyCons(userId);
      //assert
      verify(mockRepo.getMyCons(userId));
      expect(result, Right(list));
    },
  );
}
