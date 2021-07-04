import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/app.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:tabibi/features/authentication/presentation/pages/auth_screen.dart';
import 'package:tabibi/features/authentication/presentation/pages/user_info.dart';
import 'injuction.dart' as inj;

void main() {
  inj.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => inj.gi<AuthCubit>(),
      child: SafeArea(
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthScreen(),
          routes: {
            UserInfoScreen.pathName: (_) => UserInfoScreen(),
            AppScreen.pathName: (_) => AppScreen(),
          },
        ),
      ),
    );
  }
}
