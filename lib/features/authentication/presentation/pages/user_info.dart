import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/features/authentication/domain/entities/user.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart';

class UserInfoScreen extends StatelessWidget {
  GlobalKey _formKey = GlobalKey();
  FocusNode _age = FocusNode();
  FocusNode _number = FocusNode();
  User? user;
  String name = '', phone = '';
  double age = 0;

  void _submit(context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    final state = cubit.state;
    if (state is AuthenticatedState) user = state.user;

    
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
                children: [
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
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Phone number'),
                    textInputAction: TextInputAction.next,
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
                      FocusScope.of(context).requestFocus(_number);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
