import 'package:flutter/material.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';

import 'doctor_grid_item.dart';

class DoctorsGrid extends StatelessWidget {
  final List<Doctor> _doctors;

  DoctorsGrid(this._doctors);
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          crossAxisSpacing: 18,
          childAspectRatio: 3 / 5,
        ),
        itemBuilder: (_, i) => DoctorGridItem(_doctors[i]));
  }
}
