import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/app.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:tabibi/features/authentication/presentation/pages/auth_screen.dart';
import 'package:tabibi/splash_screen.dart';

class InitApp extends StatefulWidget {
  @override
  _InitAppState createState() => _InitAppState();
}

class _InitAppState extends State<InitApp> {
  bool _initW = true;

  @override
  void didChangeDependencies() {
    if (_initW) {
      final cubit = BlocProvider.of<AuthCubit>(context);
      cubit.tryLoginUser();
      _initW = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (_, state) {
        if (state is AuthenticatedState)
          Navigator.of(context).pushReplacementNamed(AppScreen.routeName);
        else if (state is LogoutState)
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
      },
      child: SplashScreen(),
    );
  }
}
