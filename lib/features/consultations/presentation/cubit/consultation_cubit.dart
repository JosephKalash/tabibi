import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  void AddConsultation(ConsultationModel cons){}
}
