import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_cons_bySpeci.dart';

import 'add_cons_test.mocks.dart';

void main() {
  final mockRepo = MockConsultationRepo();
  final getConsBySpeci = GetConsBySpeci(mockRepo);

  final date = DateTime.now();

  final list = [
    Consultation(
      'clinicSpecialization',
      'title',
      'content',
      date,
    )
  ];
  final speci = 'hi';
  test(
    'should return list of cons',
    () async {
      //arrange
      when(mockRepo.getConsBySpeci(any)).thenAnswer((_) async => Right(list));
      //act
      final result = await getConsBySpeci(speci);
      //assert
      verify(mockRepo.getConsBySpeci(speci));
      expect(result, Right(list));
    },
  );
}
