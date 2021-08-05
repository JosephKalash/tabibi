import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabibi/core/utils/funcs.dart';
import 'package:tabibi/features/doctors/domain/usecases/get_doctors.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final GetDoctors _getDoctors;

  DoctorsCubit(this._getDoctors) : super(DoctorsInitial());

  Future<void> getDoctors() async {
    emit(Loading());

    final either = await _getDoctors();

    either.fold(
      (error) => emit(DoctorError(getErrorMessage(error))),
      (doctors) => emit(GotDoctors(doctors)),
    );
  }
}
