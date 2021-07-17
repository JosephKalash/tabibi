import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/app.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart';

// ignore: must_be_immutable
class UserInfoScreen extends StatelessWidget {
  static final pathName = '/userInfo';

  final _formKey = GlobalKey<FormState>();
  final _age = FocusNode();
  final _number = FocusNode();
  User? user;
  String name = '', phone = '';
  double age = 0;

  void _submit(context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    
    final cubit = BlocProvider.of<AuthCubit>(context, listen: false);
    final state = cubit.state;
    if (state is AuthenticatedState) user = state.user;

    user!.name = name;
    user!.age = age;
    user!.phoneNumber = phone;
    Navigator.of(context).pushReplacementNamed(AppScreen.pathName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 8,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'fill the info please.',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      name = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'The name can\'t be empty';
                      if (value.length < 3) return 'the name is very short';
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_age);
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'age'),
                    textInputAction: TextInputAction.next,
                    focusNode: _age,
                    onSaved: (value) {
                      age = double.parse(value!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'The age can\'t be empty';
                      if (value.length < 15)
                        return 'the allowed age is above 14';
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_number);
                    },
                  ),
                  SizedBox(height: 14),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Phone number'),
                    textInputAction: TextInputAction.done,
                    focusNode: _number,
                    onSaved: (value) {
                      phone = value!;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'The phone number can\'t be empty';
                      if (value.length < 10)
                        return 'the number must be 10 digits';
                      return null;
                    },
                    onFieldSubmitted: (_) {
                      _submit(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        child: Text('submit'),
        onPressed: () => _submit(context),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          primary: Colors.blue.shade800,
          elevation: 8,
        ),
      ),
    );
  }
}
