import 'package:equatable/equatable.dart';
import 'package:tabibi/features/consultations/domain/entities/cons_response.dart';

// ignore: must_be_immutable
class Consultation extends Equatable {
  String? userId;
  final clinicSpecialization;
  final title;
  final content;
  final DateTime date;
  int? patientAge;
  ConsResponse? consResponse;

  Consultation(
    this.clinicSpecialization,
    this.title,
    this.content,
    this.date, {
    this.userId,
    this.patientAge,
    ConsResponse? consResponse,
  });

  @override
  List<Object?> get props => [
        userId,
        clinicSpecialization,
        title,
        content,
        date.toIso8601String(),
        patientAge,
      ];
}
