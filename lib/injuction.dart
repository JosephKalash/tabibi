import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tabibi/features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'package:tabibi/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:tabibi/features/authentication/domain/usecases/login.dart';

import 'core/network/internet_info.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/domain/usecases/signin.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';

final gi = GetIt.instance;
void init() {
  gi.registerFactory(() => AuthCubit(
        gi(),
        gi(),
        gi(),
      ));

  gi.registerLazySingleton(() => Login(gi()));
  gi.registerLazySingleton(() => Logout());
  gi.registerLazySingleton(() => Signin(gi()));

  gi.registerLazySingleton<AuthRepository>(() => AuthRepoImpl(
        gi(),
        gi(),
      ));

  gi.registerLazySingleton<InternetInfo>(() => InternetInfoImpl(gi()));

  gi.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(gi()));

  gi.registerLazySingleton(() => InternetConnectionChecker());
  gi.registerLazySingleton(() => Dio());
}
