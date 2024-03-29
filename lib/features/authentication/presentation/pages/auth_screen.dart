import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/app.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:tabibi/features/authentication/presentation/pages/user_info.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(80, 80, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 94),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent.shade700,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                      child: Text(
                        'Tabibi',
                        style: TextStyle(
                          color: Theme.of(context)
                              .accentTextTheme
                              .headline6
                              ?.color,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    kUserEmail: '',
    kPassword: '',
  };
  final _passwordController = TextEditingController();
  final _passwordAgainFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween(
      begin: Offset(0.0, -0.5),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    ));
    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    ));
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('An error occurred!'),
              content: Text(message),
              actions: <Widget>[_flatButtonDialog(ctx)],
            )
          : AlertDialog(
              title: const Text('حدث خطأ'),
              contentPadding:
                  EdgeInsets.only(right: 24, left: 24, top: 20, bottom: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              content: Text(message),
              actions: [_flatButtonDialog(ctx)],
            ),
    );
  }

  TextButton _flatButtonDialog(BuildContext ctx) {
    return TextButton(
      onPressed: () {
        Navigator.of(ctx).pop();
      },
      child: const Text('حسناً'),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController!.reverse();
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final cubit = BlocProvider.of<AuthCubit>(context);
    if (_authMode == AuthMode.Signup) {
      cubit.signinUser(_authData[kUserEmail]!, _authData[kPassword]!);
    } else {
      cubit.loginUser(_authData[kUserEmail]!, _authData[kPassword]!);
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 320 : 260,
        width: deviceSize.width * 0.75,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 320 : 260,
        ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'الأيميل'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains(
                          '@',
                        )) return 'الأيميل غير صالح';

                    return null;
                  },
                  onSaved: (value) {
                    _authData[kUserEmail] = value!;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'كلمة السر'),
                  obscureText: true,
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  textInputAction: _authMode == AuthMode.Signup
                      ? TextInputAction.next
                      : TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5)
                      return 'كلمة السر يجب أن تكون 6 أحرف على الأقل';

                    return null;
                  },
                  onSaved: (value) {
                    _authData[kPassword] = value!;
                  },
                  onFieldSubmitted: _authMode == AuthMode.Signup
                      ? (_) {
                          FocusScope.of(context)
                              .requestFocus(_passwordAgainFocusNode);
                        }
                      : (_) {
                          _submit();
                        },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  child: FadeTransition(
                    opacity: _opacityAnimation!,
                    child: SlideTransition(
                      position: _slideAnimation!,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration: const InputDecoration(
                          labelText: 'تأكيد كلمة السر',
                        ),
                        obscureText: true,
                        focusNode: _passwordAgainFocusNode,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text)
                                  return 'كلمة السر لا تتطابق مع الأساسية';
                                return null;
                              }
                            : null,
                        onFieldSubmitted: _authMode == AuthMode.Signup
                            ? (_) {
                                _submit();
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (_, state) {
                    if (state is AuthenticatedState) {
                      _authMode == AuthMode.Signup
                          ? Navigator.of(context).pushNamed(
                              UserInfoScreen.routeName,
                              arguments: _authData[kUserEmail],
                            )
                          : Navigator.of(context).pushReplacementNamed(
                              AppScreen.routeName,
                            );
                    } else if (state is ErrorState)
                      _showErrorDialog(state.message);
                  },
                  builder: (_, state) {
                    if (state is LoadingState)
                      return CircularProgressIndicator();
                    return _buildElevatedButton();
                  },
                ),
                TextButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'أنشاء حساب' : 'تسجيل الدخول'} بدلا من ذلك',
                  ),
                  onPressed: _switchAuthMode,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 4,
                    ),
                    textStyle: TextStyle(color: Colors.grey.shade600),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildElevatedButton() {
    return ElevatedButton(
      child: Text(
        _authMode == AuthMode.Login ? 'تسجيل الدخول' : 'أنشاء حساب',
      ),
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        primary: Colors.blueAccent.shade700,
        textStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
