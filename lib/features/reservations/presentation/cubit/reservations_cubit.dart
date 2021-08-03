import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit() : super(ReservationsInitial());
}
