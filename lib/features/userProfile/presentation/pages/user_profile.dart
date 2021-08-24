import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/core/utils/widgets/top_edges-container.dart';
import 'package:tabibi/features/userProfile/domain/entities/person.dart';
import 'package:tabibi/features/userProfile/presentation/cubit/userprofile_cubit.dart';

class UserProfileScreen extends StatefulWidget {
  static const pathName = '/user_profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //_fetchPersonInfo(context);

    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocBuilder<UserprofileCubit, UserprofileState>(
        builder: (_, state) {
          //if (state is GotPersonInfo) {
          //final person = state.person;
          final Person? person = Person(
            'جوزيف كلش',
            25,
            '0992365650',
            'joseph@gmail.com',
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 2 / 5,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(180),
                      ),
                      child: Icon(
                        Icons.person_outline,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      person?.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TopEdgesContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.blue,
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${person?.email ?? 'الأيميل غير متوفر'}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(thickness: 2),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.blue,
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${person?.age ?? 'العمر غير متوفر'}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Divider(thickness: 2),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                color: Colors.blue,
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${person?.phoneNumber ?? 'الرقم غير متوفر'}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
          // }
          // return SizedBox();
        },
      ),
    );
  }

  void _fetchPersonInfo(BuildContext context) {
    final cubit = BlocProvider.of<UserprofileCubit>(context);
    cubit.getPersonInfo();
  }
}