import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final name;
  final age;
  final phoneNumber;
  final email;

  Person(
    this.name,
    this.age,
    this.phoneNumber,
    this.email
  );

  @override
  List<Object?> get props => [
        name,
        age,
        phoneNumber,
        email,
      ];
}
