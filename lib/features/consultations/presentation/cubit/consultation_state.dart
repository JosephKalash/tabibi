part of 'consultation_cubit.dart';

abstract class ConsultationState extends Equatable {
  const ConsultationState();

  @override
  List<Object> get props => [];
}

class ConsultationInitial extends ConsultationState {}

class Loading extends ConsultationState {}

class AddedConsultation extends ConsultationState{
}

class _GotConsState extends ConsultationState{
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
class ErrorState extends ConsultationState {
  final message;

  ErrorState(this.message);

   @override
  List<Object> get props => [];

}