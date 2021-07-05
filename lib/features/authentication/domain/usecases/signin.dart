
import 'package:dartz/dartz.dart';
import 'package:tabibi/core/usecase/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Signin extends Usecase{
  final AuthRepository _authRepo;

  Signin(this._authRepo);

  Future<Either<Failure, User>> call(String username,String password) async {
    return  _authRepo.signin(username,password);
  }
}