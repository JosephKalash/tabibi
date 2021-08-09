import 'package:flutter/material.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/doctors/domain/entities/doctor.dart';
import 'package:tabibi/features/doctors/presentation/pages/doctor_profile.dart';

class DoctorGridItem extends StatelessWidget {
  final Doctor _doctor;

  const DoctorGridItem(this._doctor);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(DoctorProfileScreen.pathName);
        },
        child: Hero(
          tag: kDoctorImageKey,
          child: _doctor.imagePath == null || _doctor.imagePath!.isEmpty
              ? Image.asset('assets/images/person.png')
              : Image.network(_doctor.imagePath!),
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.white,
        title: Text(_doctor.name),
        subtitle: Text(_doctor.specialization),
      ),
    );
  }
}
