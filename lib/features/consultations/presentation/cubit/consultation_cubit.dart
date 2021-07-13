import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/core/utils/funcs.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';
import 'package:tabibi/features/consultations/domain/usecasese/add_cons.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_cons.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_cons_bySpeci.dart';
import 'package:tabibi/features/consultations/domain/usecasese/get_my_cons.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  final AddCons _addCons;
  final GetCons _getCons;
  final GetMyCons _getMyCons;
  final GetConsBySpeci _getConsBySpeci;

  ConsultationCubit(
    this._addCons,
    this._getCons,
    this._getMyCons,
    this._getConsBySpeci,
  ) : super(ConsultationInitial());

  void addConsultation(ConsultationModel cons) async {
    emit(Loading());

    final isSuccess = await _addCons(cons);
    isSuccess
        ? emit(AddedConsultation())
        : emit(ErrorState(kAddConsErrorMessage));
  }

  Future<void> getConsultation() async {
    _fetchConsultations(
      () => _getCons(),
      (consultations) => emit(GotConsultations(consultations)),
    );
  }

  void getMyConsultation(String userId) async {
    _fetchConsultations(
      () => _getMyCons(userId),
      (consultations) => emit(GotMyConsultations(consultations)),
    );
  }

  void getConsultationBySpeci(String specialization) async {
    _fetchConsultations(
      () => _getConsBySpeci(specialization),
      (consultations) => emit(GotConsultationsBySpeci(consultations)),
    );
  }

  Future<void> _fetchConsultations(Function fetch, Function emitState) async {
    emit(Loading());

    final either = await fetch();

    either.fold(
      (error) => _emitErrorState(error),
      (consultations) => emitState(consultations),
    );
  }

  void _emitErrorState(Failure error) {
    final errorMessage = getErrorMessage(error);
    emit(ErrorState(errorMessage));
  }
}
