import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/doctors_cubit.dart';
import '../widgets/DoctorsGrid.dart';
import 'reservations_screen.dart';

class DoctorsScreen extends StatefulWidget {
  static const pathName = '/doctors';

  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  bool _initWidget = true;

  @override
  void didChangeDependencies() {
    if (_initWidget) {
      final cubit = 
      _initWidget = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأطباء'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context).pushNamed(ReservationsScreen.pathName);
            },
          ),
        ],
      ),
      body: BlocBuilder<DoctorsCubit, DoctorsState>(
        builder: (_, state) {
          if (state is Loading)
            return CircularProgressIndicator();
          else if (state is GotDoctors)
            return DoctorsGrid(state.doctors);
          else if (state is DoctorError)
            return Center(child: Text(state.message));
          else
            return Center(child: Text('فشل في الأتصال بالمخدم'));
        },
      ),
    );
  }
}
