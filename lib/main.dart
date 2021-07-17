import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/app.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:tabibi/features/authentication/presentation/pages/auth_screen.dart';
import 'package:tabibi/features/authentication/presentation/pages/user_info.dart';
import 'package:tabibi/features/consultations/presentation/pages/add_consultations.dart';
import 'package:tabibi/features/consultations/presentation/pages/consultations_page.dart';
import 'package:tabibi/features/specializations/presentation/cubit/specializations_cubit.dart';
import 'features/consultations/presentation/cubit/consultation_cubit.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Lato',
        ),
        home: AppScreen(),
        routes: {
          UserInfoScreen.pathName: (_) => UserInfoScreen(),
          AppScreen.pathName: (_) => AppScreen(),
          AddConsultaionScreen.pathName: (_) => AddConsultaionScreen(),
          ConsultationsScreen.pathName: (_) => _buildConsultaionsScreen(),
        },
      ),
    );
  }

  BlocProvider<SpecializationsCubit> _buildConsultaionsScreen() {
    return BlocProvider(
      create: (_) => inj.gi<SpecializationsCubit>(),
      child: ConsultationsScreen(),
    );
  }
}
