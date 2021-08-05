import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Doctor extends Equatable {
  final name;
  final specialization;
  final location;
  String? phoneNumber;
  String? imagePath;

  Doctor(
    this.name,
    this.specialization,
    this.location, {
    this.phoneNumber,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        name,
        specialization,
        location,
        phoneNumber,
        imagePath,
      ];
}
