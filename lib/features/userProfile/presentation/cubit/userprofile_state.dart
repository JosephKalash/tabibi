part of 'userprofile_cubit.dart';

abstract class UserprofileState extends Equatable {
  const UserprofileState();

  @override
  List<Object?> get props => [];
}

class UserprofileInitial extends UserprofileState {}

class GotPersonInfo extends UserprofileState {
  final Person? person;

  GotPersonInfo(this.person);

  @override
  List<Object?> get props => [this.person];
}
