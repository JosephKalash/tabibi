import 'package:equatable/equatable.dart';
import 'package:tabibi/features/consultations/domain/entities/cons_response.dart';

// ignore: must_be_immutable
class Consultation extends Equatable {
  final clinicSpecialization;
  final title;
  final content;
  final DateTime date;
  ConsResponse? consResponse;

  Consultation(
    this.clinicSpecialization,
    this.title,
    this.content,
    this.date, {
    consResponse,
  });

  @override
  List<Object?> get props => [
        clinicSpecialization,
        title,
        content,
        date.toIso8601String(),
      ];
}
