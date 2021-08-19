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
      backgroundColor: Colors.indigo.shade100,
      body: Center(
        child: SizedBox(
          width: 300,
          height: 410,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الرجاء كتابة المعلومات الشخصية',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'الأسم الكامل'),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              name = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'لا يمكن أن يكون حقل الأسم فارغ';
                              if (value.length < 3) return 'الأسم قصير جدا';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_age);
                            },
                          ),
                          SizedBox(height: 14),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'العمر'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _age,
                            onSaved: (value) {
                              age = double.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'لا يمكن أن يكون حقل المر فارغ';
                              if (value.length < 15)
                                return 'العمر المسموح به لأستخدام التطبيق فوق 14 سنة';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_number);
                            },
                          ),
                          SizedBox(height: 14),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'رقم الجوال'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            focusNode: _number,
                            onSaved: (value) {
                              phone = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'لا يمكن أن يكون حقل الهاتف فارغ';
                              if (value.length < 10)
                                return 'يجب أن يكون الرقم مؤلف من 10 أرقام';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _submit(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      '**سيتم استخدام هذه المعلومات عند استخدام خدمات التطبيق الرجاء كتابة معلومات صحيحة',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (_, state) {
                        if (state is LoadingState)
                          return CircularProgressIndicator();
                        return ElevatedButton(
                          child: Text('حفظ'),
                          onPressed: () => _submit(context),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            primary: Colors.blue.shade800,
                            elevation: 8,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
