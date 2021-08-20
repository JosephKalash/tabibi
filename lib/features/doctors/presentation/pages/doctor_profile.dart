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
            height: MediaQuery.of(context).size.height / 3,
            child: Hero(
              tag: _doctor.id,
              child: Image.asset(
                'assets/images/doctorL.png',
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          _doctor.specialization,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 2),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Colors.blue,
                          size: 28,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${_doctor.phoneNumber ?? 'الرقم غير متوفر'}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 2),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.blue,
                          size: 28,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '${_doctor.address ?? 'العنوان غير متوفر'}',
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
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: ElevatedButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (ctx) => AddReservationForm(_doctor.id, ctx),
              ),
              child: Text('حجز'),
              style: ElevatedButton.styleFrom(elevation: 8),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
