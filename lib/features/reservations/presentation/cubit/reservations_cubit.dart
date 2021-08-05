import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabibi/core/utils/funcs.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';
import 'package:tabibi/features/reservations/domain/usecases/add_reservation.dart';
import 'package:tabibi/features/reservations/domain/usecases/cancel_reservation.dart';
import 'package:tabibi/features/reservations/domain/usecases/get_reservations.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  final GetReservations _getReservations;
  final AddReservation _addReservation;
  final CancelReservation _cancelReservation;

  ReservationsCubit(
    this._getReservations,
    this._addReservation,
    this._cancelReservation,
  ) : super(ReservationsInitial());

  Future<void> addReservation(Reservation reservation) async {
    emit(Loading());

    final isSuccess = await _addReservation(reservation);

    emit(AddedReservation(isSuccess));
  }

  Future<void> cancelReservation(Reservation reservation) async {
    emit(Loading());

    final isSuccess = await _cancelReservation(reservation);

    emit(CanceledReservation(isSuccess));
  }

  Future<void> getReservations() async {
    emit(Loading());

    final either = await _getReservations();

    either.fold(
      (error) => emit(ReservationError(getErrorMessage(error))),
      (reservations) => emit(GotReservation(reservations)),
    );
  }
}
