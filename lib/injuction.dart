import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/features/authentication/domain/usecases/auto_login.dart';

import 'core/network/internet_info.dart';
import 'features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/domain/usecases/login.dart';
import 'features/authentication/domain/usecases/logout.dart';
import 'features/authentication/domain/usecases/signin.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';
import 'features/consultations/data/data%20sources/cons_ds.dart';
import 'features/consultations/data/repositories/consultation_repo.dart';
import 'features/consultations/domain/repositories/consultation_repo.dart';
import 'features/consultations/domain/usecasese/add_cons.dart';
import 'features/consultations/domain/usecasese/get_cons.dart';
import 'features/consultations/domain/usecasese/get_cons_bySpeci.dart';
import 'features/consultations/domain/usecasese/get_my_cons.dart';
import 'features/consultations/presentation/cubit/consultation_cubit.dart';
import 'features/doctors/data/data%20source/doctor_DS.dart';
import 'features/doctors/data/repositories/doctor_repo_impl.dart';
import 'features/doctors/domain/repositories/doctor_repository.dart';
import 'features/doctors/domain/usecases/get_doctors.dart';
import 'features/doctors/presentation/cubit/doctors_cubit.dart';
import 'features/reservations/data/data%20sources/reservation_data_source.dart';
import 'features/reservations/data/repositories/reservation_repository_impl.dart';
import 'features/reservations/domain/repositories/reservation_repository.dart';
import 'features/reservations/domain/usecases/add_reservation.dart';
import 'features/reservations/domain/usecases/cancel_reservation.dart';
import 'features/reservations/domain/usecases/get_reservations.dart';
import 'features/reservations/presentation/cubit/reservations_cubit.dart';
import 'features/specializations/data/data%20sources/specialization_DS.dart';
import 'features/specializations/data/repositories/speci_repo_impl.dart';
import 'features/specializations/domain/repositories/special_repo.dart';
import 'features/specializations/domain/usecases/get_specializations.dart';
import 'features/specializations/presentation/cubit/specializations_cubit.dart';
import 'features/userProfile/data/data%20source/person_local_DS.dart';
import 'features/userProfile/data/repositories/person_repo_impl.dart';
import 'features/userProfile/domain/repositories/person_repository.dart';
import 'features/userProfile/domain/usecases/get_person_info.dart';
import 'features/userProfile/presentation/cubit/userprofile_cubit.dart';

final gi = GetIt.instance;
Future<void> init() async {
  //// Auth
  gi.registerFactory(
    () => AuthCubit(gi(), gi(), gi(), gi()),
  );

  gi.registerLazySingleton(() => Login(gi()));
  gi.registerLazySingleton(() => Logout());
  gi.registerLazySingleton(() => Signin(gi()));
  gi.registerLazySingleton(() => AutoLogin(gi()));

  gi.registerLazySingleton<AuthRepository>(
    () => AuthRepoImpl(gi(), gi()),
  );

  gi.registerLazySingleton<InternetInfo>(
    () => InternetInfoImpl(gi()),
  );

  gi.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(gi(), gi()),
  );
// final dio = Dio(
//         BaseOptions(
//           connectTimeout: 20000,
//           baseUrl: Endpoints.BASE_URL,
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//           },
//           responseType: ResponseType.plain,
//         ),
//       );
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
  ///doctor
  gi.registerFactory(
    () => DoctorsCubit(gi()),
  );

  gi.registerLazySingleton(
    () => GetDoctors(gi()),
  );

  gi.registerLazySingleton<DoctorRepo>(
    () => DoctorRepoImpl(gi(), gi()),
  );

  gi.registerLazySingleton<DoctorDS>(
    () => DoctorDSImpl(gi(), gi()),
  );

  ///doctor end
  ///user profile
  gi.registerFactory(
    () => UserprofileCubit(gi()),
  );
  gi.registerLazySingleton(
    () => GetPersonInfo(gi()),
  );
  gi.registerLazySingleton<PersonRepo>(
    () => PersonRepoImpl(gi()),
  );
  gi.registerLazySingleton<PersonLocalDS>(
    () => PersonLocalDSImpl(gi(),gi()),
  );

  ///user profile end
}
