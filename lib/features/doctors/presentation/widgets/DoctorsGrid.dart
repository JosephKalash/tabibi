import 'package:flutter/material.dart';

import '../../domain/entities/doctor.dart';
import 'doctor_grid_item.dart';

class DoctorsGrid extends StatelessWidget {
  final List<Doctor> _doctors;

  DoctorsGrid(this._doctors);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
