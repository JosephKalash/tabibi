import 'package:flutter/material.dart';
import 'package:tabibi/features/doctors/data/models/doctor_model.dart';

import '../../../../core/utils/constaints.dart';
import '../../domain/entities/doctor.dart';
import '../widgets/reservation_form.dart';

class DoctorProfileScreen extends StatefulWidget {
  static const pathName = '/doctorProfile';

  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Doctor _doctor = DoctorModel.fromJson(
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>,
    );

    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Hero(
              tag: kDoctorImageKey,
              child: _doctor.imagePath == null || _doctor.imagePath!.isEmpty
                  ? Image.asset(
                      'assets/images/person.png',
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      _doctor.imagePath!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Text(
                          _doctor.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          _doctor.name,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 8),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        color: Colors.blue,
                      ),
                      Text('${_doctor.phoneNumber ?? 'الرقم غير متوفر'}'),
                    ],
                  ),
                  Divider(thickness: 8),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                      ),
                      Text('${_doctor.address ?? 'العنوان غير متوفر'}'),
                    ],
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (ctx) => AddReservationForm(_doctor.id, ctx),
            ),
            child: Text('حجز'),
            style: ElevatedButton.styleFrom(elevation: 8),
          ),
        ],
      ),
    );
  }
}
