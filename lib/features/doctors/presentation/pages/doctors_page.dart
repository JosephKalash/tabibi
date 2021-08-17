import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/features/doctors/presentation/cubit/doctors_cubit.dart';
import 'package:tabibi/features/doctors/presentation/pages/reservations_screen.dart';
import 'package:tabibi/features/doctors/presentation/widgets/DoctorsGrid.dart';

class DoctorsScreen extends StatelessWidget {
  static const pathName = '/doctors';

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
