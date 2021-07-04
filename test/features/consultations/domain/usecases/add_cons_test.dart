import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';
import 'package:tabibi/features/consultations/domain/repositories/consultation_repo.dart';
import 'package:tabibi/features/consultations/domain/usecasese/add_cons.dart';

import 'add_cons_test.mocks.dart';

@GenerateMocks([ConsultationRepo])
void main() {
  final mockRepo = MockConsultationRepo();
  final addCons = AddCons(mockRepo);

  final date = DateTime.now();

  final con = Consultation(
    'clinicSpecialization',
    'title',
    'content',
    date,
  );
  test(
    'should call repo.addCons when AddCons usecase is called',
    () async {
      //arrange
      when(mockRepo.addConsultation(any)).thenAnswer((_) async => true);
      //act
      final result = await addCons(con);
      //assert
      verify(mockRepo.addConsultation(con));
      expect(result, true);
    },
  );
}
