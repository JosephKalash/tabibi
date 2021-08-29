import 'package:dartz/dartz.dart';

import '../../../../core/error/excpetions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/internet_info.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data%20sources/auth_remote_data_source.dart';

class AuthRepoImpl extends AuthRepository {
  final InternetInfo _internetInfo;
  final AuthRemoteDataSource _remoteDS;

  AuthRepoImpl(this._internetInfo, this._remoteDS);

  @override
  Future<Either<Failure, User>> signin(String username, String password) async {
    return _authantic(username, password, _remoteDS.signinUser);
  }

  Future<Either<Failure, User>> _authantic(
      String username, String password, Function call) async {
    if (await _internetInfo.isConnect) {
      try {
        final user = await call(username, password);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      } on HttpException catch (e) {
        return Left(HttpFailure(e.message));
      }
    } else {
      return Left(InternetFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    return _authantic(username, password, _remoteDS.loginUser);
  }

  @override
  bool tryAutoLogin() {
    final isLogin = _remoteDS.tryAutoLoginUser();
    return isLogin;
  }
}
