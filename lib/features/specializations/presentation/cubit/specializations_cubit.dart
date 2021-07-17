import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabibi/core/utils/funcs.dart';
import 'package:tabibi/features/specializations/domain/entities/specialization.dart';
import 'package:tabibi/features/specializations/domain/usecases/get_specializations.dart';

part 'specializations_state.dart';

class SpecializationsCubit extends Cubit<SpecializationsState> {
  final GetSpecials _getSpecials;

  SpecializationsCubit(this._getSpecials) : super(SpecializationsInitial());

  Future<void> getSpecializations() async {
    final either = await _getSpecials();
    either.fold(
      (error) {
        final message = getErrorMessage(error);
        emit(ErrorSpeciState(message));
      },
      (speciaList) => emit(GotSpecials(speciaList)),
    );
  }
}
