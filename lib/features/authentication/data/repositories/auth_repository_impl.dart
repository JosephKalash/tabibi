import 'package:dartz/dartz.dart';
import 'package:tabibi/core/error/excpetions.dart';
import 'package:tabibi/core/error/failures.dart';
import 'package:tabibi/core/network/internet_info.dart';
import 'package:tabibi/features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';
import 'package:tabibi/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepoImpl extends AuthRepository {
  final InternetInfo internetInfo;
  final AuthRemoteDataSource remoteDS;

  AuthRepoImpl(this.internetInfo, this.remoteDS);

  @override
  Future<Either<Failure, User>> signin(String username, String password) async {
    if (await internetInfo.isConnect) {
      try {
        final user = await remoteDS.signinUser(username, password);
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
  Future<Either<Failure, User>> login(String username, String password) {
    throw UnimplementedError();
  }
}
