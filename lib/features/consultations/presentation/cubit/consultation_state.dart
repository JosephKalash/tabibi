part of 'consultation_cubit.dart';

abstract class ConsultationState extends Equatable {
  const ConsultationState();

  @override
  List<Object> get props => [];
}

class ConsultationInitial extends ConsultationState {}

class Loading extends ConsultationState {}

class AddedConsultation {
  final bool isSuccess;

  AddedConsultation(this.isSuccess);

  List<Object> get props => [isSuccess];
}

class _GotConsState {
  final consultations;

  _GotConsState(this.consultations);

  List<Object> get props => [consultations];
}

class GotConsultations extends _GotConsState {
  GotConsultations(consultations) : super(consultations);
}

class GotMyConsultations extends _GotConsState {
  GotMyConsultations(consultations) : super(consultations);
}

class GotConsultationsBySpeci extends _GotConsState {
  GotConsultationsBySpeci(consultations) : super(consultations);
}
