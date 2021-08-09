import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Doctor extends Equatable {
  final id;
  final name;
  final specialization;
  final address;
  String? phoneNumber;
  String? imagePath;

  Doctor(
    this.id,
    this.name,
    this.specialization,
    this.address, {
    this.phoneNumber,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        specialization,
        address,
        phoneNumber,
        imagePath,
      ];
}
