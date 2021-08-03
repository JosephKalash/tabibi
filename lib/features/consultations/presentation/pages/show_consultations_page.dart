import 'package:flutter/material.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

class DisplayConsultationScreen extends StatelessWidget {
  final Consultation _consultation;

  const DisplayConsultationScreen(this._consultation);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاستشارة',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(
                          spacing: 2,
                          children: [
                            Text(
                              'منذ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: kSmallSize,
                              ),
                            ),
                            Text(
                              '${DateTime.now().difference(_consultation.date).inDays}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: kSmallSize,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.inbox_outlined,
                          color: Colors.blue.shade900,
                        ),
                      ],
                    ),
                    Text(
                      _consultation.content,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      _consultation.clinicSpecialization,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: kSmallSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 5,
              color: Colors.grey,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              constraints: BoxConstraints(minHeight: 60),
              child: SingleChildScrollView(
                child: _consultation.consResponse == null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          margin: EdgeInsets.all(6),
                          decoration: BoxDecoration(shape: BoxShape.rectangle),
                          color: Colors.blue,
                          child: Text('لا يوجد رد بعد'),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Wrap(
                            spacing: 4,
                            children: [
                              Icon(Icons.face),
                              Text(_consultation.consResponse?.doctorName),
                            ],
                          ),
                          const SizedBox(width: 10),
                          Wrap(
                            spacing: 4,
                            direction: Axis.vertical,
                            children: [
                              Container(
                                margin: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.blue,
                                child: Text(_consultation.consResponse?.response),
                              ),
                              Text(
                                '${DateTime.now().difference(_consultation.consResponse!.date).inDays}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'لن يتم أظهار المعلومات الشخصية ضمن اي استشارة منشورة للعامة',
            ),
          ],
        ),
      ),
    );
  }
}
