import 'package:flutter/material.dart';
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
          textDirection: TextDirection.rtl,
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Wrap(
                  children: [],
                ),
                Text(''),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Row(
              children: [
                Wrap(children: [],),
                Text(''),
              ],
            ),
          ),
          SizedBox(
            height: 14,
          ),
          Text(''),
        ],
      ),
    );
  }
}
