import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  ReservationModel(
    doctorId,
    userId,
    DateTime date,
    {
    ReservationStatus? status,
    String? doctorName,
  }) : super(doctorId, userId, date,
            status: status, doctorName: doctorName);

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      json[kDoctorId],
      json[kUserIdKey],
      DateTime.parse(json[kReservationDate]),
      status: _getStatus(json[kReservationStatus]),
      doctorName: json[kDoctorName],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      kDoctorId: doctorId,
      kUserIdKey: userId,
      kReservationDate: date.toIso8601String(),
      kReservationStatus: status == null ? '' : status.toString(),
      kDoctorName: doctorName ?? '',
    };
  }

  factory ReservationModel.fromParent(Reservation reservation) {
    return ReservationModel(
      reservation.doctorId,
      reservation.userId,
      reservation.date,
      status: reservation.status,
      doctorName: reservation.doctorName,
    );
  }
}

ReservationStatus? _getStatus(String? status) {
  if (status == null) return null;
  for (ReservationStatus value in ReservationStatus.values)
    if (value.toString() == status) return value;

  ///TODO: could enum.toString be equal to string
  return ReservationStatus.None;
}