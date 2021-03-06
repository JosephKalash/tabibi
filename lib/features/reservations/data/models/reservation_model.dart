import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/reservations/domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  ReservationModel(
    id,
    doctorId,
    DateTime date, {
    ReservationStatus? status,
    String? doctorName,
    time,
  }) : super(id, doctorId, date,
            status: status, doctorName: doctorName, time: time);

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return ReservationModel(
      json[kReservationId],
      json[kClinicId],
      DateTime.parse(json[kReservationDate]),
      status: _getStatus(json[kReservationStatus]),
      doctorName: json[kDoctorName],
      time: json[kReservationTime] == null
          ? null
          : (json[kReservationTime] as String).substring(0,5),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kClinicId: doctorId,
      kReservationDate: date.toIso8601String(),
    };
  }

  factory ReservationModel.fromParent(Reservation reservation) {
    return ReservationModel(
      reservation.id,
      reservation.doctorId,
      reservation.date,
      status: reservation.status,
      doctorName: reservation.doctorName,
      time: reservation.time,
    );
  }
}

ReservationStatus _getStatus(String? status) {
  if (status == null) return ReservationStatus.waiting;
  switch (status) {
    case 'pending':
      return ReservationStatus.waiting;
    case 'accept':
      return ReservationStatus.Accept;
    case 'reject':
      return ReservationStatus.Reject;
    default:
      return ReservationStatus.None;
  }
}
