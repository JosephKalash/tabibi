part of 'reservations_cubit.dart';

abstract class ReservationsState extends Equatable {
  const ReservationsState();

  @override
  List<Object> get props => [];
}

class ReservationsInitial extends ReservationsState {}

class Loading extends ReservationsState {}

class ReservationError extends ReservationsState {
  final message;

  ReservationError(this.message);

  @override
  List<Object> get props => [message];
}

class AddedReservation extends ReservationsState {
  final bool isSuccess;

  AddedReservation(this.isSuccess);
  @override
  List<Object> get props => [isSuccess];
}
class CanceledReservation extends ReservationsState {
  final bool isSuccess;

  CanceledReservation(this.isSuccess);
  
  @override
  List<Object> get props => [isSuccess];
}

class GotReservation extends ReservationsState {
  final reservations;

  GotReservation(this.reservations);

  @override
  List<Object> get props => [reservations];
}
