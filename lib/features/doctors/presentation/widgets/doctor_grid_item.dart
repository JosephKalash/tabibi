import 'package:flutter/material.dart';
import 'package:tabibi/features/doctors/data/models/doctor_model.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';
import 'package:tabibi/features/doctors/presentation/pages/doctor_profile.dart';

class DoctorGridItem extends StatelessWidget {
  final Doctor _doctor;

  const DoctorGridItem(this._doctor);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue.shade100, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            final doctor = DoctorModel.fromParent(_doctor);
            Navigator.of(context).pushNamed(
              DoctorProfileScreen.routeName,
              arguments: doctor.toJson(),
            );
          },
          child: Hero(
            tag: _doctor.id,
            child: _doctor.imagePath == null || _doctor.imagePath!.isEmpty
                ? Image.asset(
                    'assets/images/doctor.png',
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    _doctor.imagePath!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        footer: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              Text(
                _doctor.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_doctor.specialization}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
