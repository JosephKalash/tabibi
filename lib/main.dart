import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tabibi/init_app.dart';
import 'features/authentication/presentation/pages/auth_screen.dart';
import 'features/consultations/presentation/pages/display_consultation_page.dart';
import 'features/doctors/presentation/cubit/doctors_cubit.dart';
import 'features/doctors/presentation/pages/doctor_profile.dart';
import 'features/doctors/presentation/pages/reservations_screen.dart';
import 'features/reservations/presentation/cubit/reservations_cubit.dart';
import 'features/userProfile/presentation/cubit/userprofile_cubit.dart';

import 'app.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';
import 'features/authentication/presentation/pages/user_info.dart';
import 'features/consultations/presentation/cubit/consultation_cubit.dart';
import 'features/consultations/presentation/pages/add_consultations.dart';
import 'features/consultations/presentation/pages/consultations_tabs_page.dart';
import 'features/specializations/presentation/cubit/specializations_cubit.dart';
import 'injuction.dart' as inj;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inj.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => inj.gi<AuthCubit>(),
        ),
        BlocProvider(
          create: (_) => inj.gi<ConsultationCubit>(),
        ),
        BlocProvider(
          create: (_) => inj.gi<SpecializationsCubit>(),
        ),
        BlocProvider(
          create: (_) => inj.gi<ReservationsCubit>(),
        ),
        BlocProvider(
          create: (_) => inj.gi<DoctorsCubit>(),
        ),
        BlocProvider(
          create: (_) => inj.gi<UserprofileCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'tabibi',
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ar', 'AE'),
        ],
        locale: Locale('ar', 'AE'),
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Lato',
        ),
        home: InitApp(),
        routes: {
          UserInfoScreen.routeName: (_) => UserInfoScreen(),
          AppScreen.routeName: (_) => AppScreen(),
          AddConsultaionScreen.routeName: (_) => AddConsultaionScreen(),
          ConsultationsTabsScreen.routeName: (_) => ConsultationsTabsScreen(),
          DisplayConsultationScreen.routeName: (_) =>
              DisplayConsultationScreen(),
          ReservationsScreen.routeName: (_) => ReservationsScreen(),
          DoctorProfileScreen.routeName: (_) => DoctorProfileScreen(),
          AuthScreen.routeName:(_)=>AuthScreen(),
        },
      ),
    );
  }
}
