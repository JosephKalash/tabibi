import 'package:flutter/material.dart';

import '../../domain/entities/doctor.dart';
import 'doctor_grid_item.dart';

// ignore: must_be_immutable
class DoctorsGrid extends StatelessWidget {
  List<Doctor> _doctors;
  final dynamic? filterSpci;
  DoctorsGrid(this._doctors, {this.filterSpci});

  @override
  Widget build(BuildContext context) {
    if (filterSpci != null) {
      _doctors = _doctors
          .where((element) => element.specialization == filterSpci)
          .toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22),
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
