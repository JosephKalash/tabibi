import 'package:equatable/equatable.dart';

class ConsResponse extends Equatable {
  final response;
  final doctorName;
  final DateTime date;

  ConsResponse(
    this.response,
    this.doctorName,
    this.date,
  );

  @override
  List<Object?> get props => [
        response,
        doctorName,
        date.toIso8601String(),
      ];
}
