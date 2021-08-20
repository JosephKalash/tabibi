import 'package:flutter/material.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';

import 'doctor_grid_item.dart';

class DoctorsGrid extends StatelessWidget {
  final List<Doctor> doctors;

  DoctorsGrid(this.doctors);
  List<Doctor> _doctors = [
    Doctor(
      'idb',
      'محدم هبي مسب',
      'داخلية',
      'دمشق رك ين',
      phoneNumber: '099323424',
    ),
    Doctor(
      'ida',
      'يب  هيبيبي ',
      ' عصبية داخلية',
      'دمشق رك ',
    ),
    Doctor(
      'ids',
      'علي حسن طاهر',
      'بيبمن نبم',
      'دمشق رك ين',
    ),
    Doctor(
      'idd',
      'النبي تلتيسي ',
      ' بييبداخلية',
      'دمشق رك ين',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        title: Text('الأطباء'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(top: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              itemCount: _doctors.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 26,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemBuilder: (_, i) => DoctorGridItem(_doctors[i]),
            ),
          ),
        ),
      ),
    );
  }
}
