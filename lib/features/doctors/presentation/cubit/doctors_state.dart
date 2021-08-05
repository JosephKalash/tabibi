part of 'doctors_cubit.dart';

abstract class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

class DoctorsInitial extends DoctorsState {}

class Loading extends DoctorsState {}

class DoctorError extends DoctorsState {
  final message;

  DoctorError(this.message);
  @override
  List<Object> get props => [message];
}

class GotDoctors extends DoctorsState {
  final doctors;

  GotDoctors(this.doctors);

  @override
  List<Object> get props => [doctors];
}
