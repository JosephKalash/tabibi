import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabibi/features/userProfile/domain/entities/person.dart';
import 'package:tabibi/features/userProfile/domain/usecases/get_person_info.dart';

part 'userprofile_state.dart';

class UserprofileCubit extends Cubit<UserprofileState> {
  final GetPersonInfo _getPersonInfo;

  UserprofileCubit(this._getPersonInfo) : super(UserprofileInitial());

  void getPersonInfo() {
    final person = _getPersonInfo();
    emit(GotPersonInfo(person));
  }
}
