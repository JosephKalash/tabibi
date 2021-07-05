import 'package:dartz/dartz.dart';
import 'package:tabibi/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Login extends Usecase{
  final AuthRepository _authRepo;

  Login(this._authRepo);

  Future<Either<Failure, User>> call(String username,String password) async {
    return  _authRepo.login(username,password);
  }
}
