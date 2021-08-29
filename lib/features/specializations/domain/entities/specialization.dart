import 'package:equatable/equatable.dart';

class Specialization extends Equatable{
  final id;
  final String name;

  Specialization(this.id, this.name);

  @override
  List<Object?> get props => [id,name];
}
