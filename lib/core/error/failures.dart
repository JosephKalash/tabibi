import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class InternetFailure extends Failure {}

class HttpFailure extends Failure {
  final message;

  HttpFailure(this.message);

  @override
  List<Object> get props => [message];
}