import 'package:tabibi/core/usecase/usecase.dart';
import 'package:tabibi/features/authentication/domain/repositories/auth_repository.dart';

class AutoLogin extends Usecase {
  final AuthRepository _repository;

  AutoLogin(this._repository);

  Future<bool> call() async{
    return _repository.tryAutoLogin();
  }
}
