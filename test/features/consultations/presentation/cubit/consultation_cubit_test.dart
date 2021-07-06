import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
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

  group(
    'add consultation',
    () {
      test(
      'should description',
      ()async {
      //arrange
      //act
      
      //assert
      
      },
      );
    },
  );
}
