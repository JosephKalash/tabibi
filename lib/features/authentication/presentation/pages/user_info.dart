import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app.dart';
import '../../../../core/utils/constaints.dart';

// ignore: must_be_immutable
class UserInfoScreen extends StatelessWidget {
  static final routeName = '/userInfo';

  final _formKey = GlobalKey<FormState>();
  final _age = FocusNode();
  final _number = FocusNode();
  String name = '', phone = '';
  int age = 0;

  Future<void> _submit(context) async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final email = ModalRoute.of(context)?.settings.arguments;
    final preferences = await SharedPreferences.getInstance();
    final map = {
      kUserName: name,
      kUserAge: age,
      kUserPhoneNumber: phone,
      kUserEmail: email,
    };
    final data = json.encode(map);

    await preferences.setString(kPersonInfoPref, data);

    //_editInfoReq(preferences, map);

    Navigator.of(context).pushReplacementNamed(AppScreen.routeName);
  }

  void _editInfoReq(SharedPreferences preferences, Map<String, dynamic> map) {
    final token = preferences.getString(kTokenKey);
    final dio = Dio();
    dio.options.headers[kAuthorization] = '$kBearer$token';
    dio
        .put(
          LOGIN_URL,
          data: map,
        )
        .catchError((_) {});
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
                      '???????????? ?????????? ?????????????????? ??????????????',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: '?????????? ????????????'),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              name = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return '???? ???????? ???? ???????? ?????? ?????????? ????????';
                              if (value.length < 3) return '?????????? ???????? ??????';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_age);
                            },
                          ),
                          SizedBox(height: 14),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: '??????????'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _age,
                            onSaved: (value) {
                              age = int.parse(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return '???? ???????? ???? ???????? ?????? ???????? ????????';
                              if (int.parse(value) < 15)
                                return '?????????? ?????????????? ???? ???????????????? ?????????????? ?????? 14 ??????';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_number);
                            },
                          ),
                          SizedBox(height: 14),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: '?????? ????????????'),
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.number,
                            focusNode: _number,
                            onSaved: (value) {
                              phone = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return '???? ???????? ???? ???????? ?????? ???????????? ????????';
                              if (value.length < 10)
                                return '?????? ???? ???????? ?????????? ???????? ???? 10 ??????????';
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
                      '**???????? ?????????????? ?????? ?????????????????? ?????? ?????????????? ?????????? ?????????????? ???????????? ?????????? ?????????????? ??????????',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      child: Text('??????'),
                      onPressed: () => _submit(context),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        primary: Colors.blue.shade800,
                        elevation: 8,
                      ),
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
