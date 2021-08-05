import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/features/consultations/data/data%20sources/cons_ds.dart';
import 'package:tabibi/features/consultations/data/repositories/consultation_repo.dart';
import 'package:tabibi/features/consultations/domain/usecasese/add_cons.dart';
import 'package:tabibi/features/consultations/presentation/cubit/consultation_cubit.dart';
import 'package:tabibi/features/reservations/data/data%20sources/reservation_data_source.dart';
import 'package:tabibi/features/reservations/domain/usecases/add_reservation.dart';
import 'package:tabibi/features/reservations/domain/usecases/cancel_reservation.dart';
import 'package:tabibi/features/reservations/domain/usecases/get_reservations.dart';
import 'package:tabibi/features/reservations/presentation/cubit/reservations_cubit.dart';
import 'package:tabibi/features/specializations/data/data%20sources/specialization_DS.dart';
import 'package:tabibi/features/specializations/data/repositories/speci_repo_impl.dart';
import 'package:tabibi/features/specializations/domain/repositories/special_repo.dart';
import 'package:tabibi/features/specializations/domain/usecases/get_specializations.dart';
import 'package:tabibi/features/specializations/presentation/cubit/specializations_cubit.dart';

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
import 'features/reservations/data/repositories/reservation_repository_impl.dart';
import 'features/reservations/domain/repositories/reservation_repository.dart';

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

  /// consultations end
  /// specialization
  gi.registerFactory(
    () => SpecializationsCubit(gi()),
  );

  gi.registerLazySingleton(
    () => GetSpecials(gi()),
  );

  gi.registerLazySingleton<SpecialRepo>(
    () => SpeciRepoImpl(gi(), gi()),
  );

  gi.registerLazySingleton<SpecializationDS>(
    () => SpecialztionDSImpl(gi()),
  );

  ///specialization end
  ///reservations
  gi.registerFactory(
    () => ReservationsCubit(gi(), gi(), gi()),
  );

  gi.registerLazySingleton(
    () => AddReservation(gi()),
  );
  gi.registerLazySingleton(
    () => CancelReservation(gi()),
  );
  gi.registerLazySingleton(
    () => GetReservations(gi()),
  );

  gi.registerLazySingleton<ReservationRepo>(
    () => ReservationRepoImpl(gi(), gi()),
  );

  gi.registerLazySingleton<ReservationDS>(
    () => ReservationDSImpl(gi(), gi()),
  );
  ///end reservation
}
