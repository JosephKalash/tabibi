import 'package:equatable/equatable.dart';

class Specialization extends Equatable{
  final String name;
  final String value;

  Specialization(this.name, this.value);

  @override
  List<Object?> get props => [name,value];
}
