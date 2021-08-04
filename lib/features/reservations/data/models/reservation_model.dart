import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  ReservationModel(
    DateTime date,
    ReservationType type, {
    ReservationStatus? status,
  }) : super(date, type, status: status);

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      DateTime.parse(json[kReservationDate]),
      _getType(json[kReservatioinType]),
      status: _getStatus(json[kReservationStatus]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kReservationDate: date.toIso8601String(),
      kReservatioinType: type.toString(),
      kReservationStatus: status == null ? '' : status.toString(),
    };
  }

  factory ReservationModel.fromParent(Reservation reservation) {
    return ReservationModel(
      reservation.date,
      reservation.type,
      status: reservation.status,
    );
  }
}

ReservationStatus? _getStatus(status) {
  if (status == null) return null;
  for (ReservationStatus value in ReservationStatus.values)
    if (value == status) return value;

  return ReservationStatus.None;
}

ReservationType _getType(type) {
  for (ReservationType value in ReservationType.values)
    if (value == type) return value;

  return ReservationType.None;
}
