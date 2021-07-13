import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/features/consultations/data/data%20sources/cons_ds.dart';
import 'package:tabibi/features/consultations/data/repositories/consultation_repo.dart';
import 'package:tabibi/features/consultations/domain/usecasese/add_cons.dart';
import 'package:tabibi/features/consultations/presentation/cubit/consultation_cubit.dart';

import 'core/network/internet_info.dart';
import 'features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/domain/usecases/signin.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';
import 'features/consultations/domain/repositories/consultation_repo.dart';
import 'features/consultations/domain/usecasese/get_cons.dart';
import 'features/consultations/domain/usecasese/get_cons_bySpeci.dart';
import 'features/consultations/domain/usecasese/get_my_cons.dart';

final gi = GetIt.instance;
Future<void> init() async {
  //// Auth
  gi.registerFactory(
    () => AuthCubit(gi(), gi(), gi()),
  );

  gi.registerLazySingleton(() => Login(gi()));
  gi.registerLazySingleton(() => Logout());
  gi.registerLazySingleton(() => Signin(gi()));

  gi.registerLazySingleton<AuthRepository>(
    () => AuthRepoImpl(gi(), gi()),
  );

  gi.registerLazySingleton<InternetInfo>(
    () => InternetInfoImpl(gi()),
  );

  gi.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(gi(), gi()),
  );

  gi.registerLazySingleton(() => InternetConnectionChecker());
  gi.registerLazySingleton(() => Dio());

  final sharedPreferences = await SharedPreferences.getInstance();
  gi.registerLazySingleton(() => sharedPreferences);
  //// auth end
  ///consultations
  gi.registerFactory(
    () => ConsultationCubit(gi(), gi(), gi(), gi()),
  );

  gi.registerLazySingleton(() => AddCons(gi()));
  gi.registerLazySingleton(() => GetCons(gi()));
  gi.registerLazySingleton(() => GetMyCons(gi()));
  gi.registerLazySingleton(() => GetConsBySpeci(gi()));

  gi.registerLazySingleton<ConsultationRepo>(
    () => ConsultationRepoImpl(gi(), gi()),
  );

  gi.registerLazySingleton<ConsultationDS>(
    () => ConsultationDSImpl(gi(), gi()),
  );
  gi.registerLazySingleton<InternetInfo>(
    () => InternetInfoImpl(gi()),
  );

  gi.registerLazySingleton(() => Dio());
  gi.registerLazySingleton(() => InternetConnectionChecker());
  
  final sharedPreferences2 = await SharedPreferences.getInstance();
  gi.registerLazySingleton(() => sharedPreferences2);
  /// consultations end
}
