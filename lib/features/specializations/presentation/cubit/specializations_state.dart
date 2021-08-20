part of 'specializations_cubit.dart';

abstract class SpecializationsState extends Equatable {
  const SpecializationsState();

  @override
  List<Object> get props => [];
}

class LoadingSpci extends SpecializationsState{}

class SpecializationsInitial extends SpecializationsState {}

class GotSpecials extends SpecializationsState {
  final List<Specialization> speciaList;

  GotSpecials(this.speciaList);

  @override
  List<Object> get props => [speciaList];
}

class ErrorSpeciState extends SpecializationsState {
  final message;

  ErrorSpeciState(this.message);

  @override
  List<Object> get props => [message];

}
