import 'package:flutter/material.dart';

import '../../../../core/utils/constaints.dart';
import '../../data/models/consultation_model.dart';
import '../../domain/entities/consultation.dart';
import '../pages/display_consultation_page.dart';

class ConsultationsList extends StatelessWidget {
  final List<Consultation> _consultaions;

  const ConsultationsList(this._consultaions);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 22),
      itemCount: _consultaions.length,
      clipBehavior: Clip.antiAlias,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  DisplayConsultationScreen.routeName,
                  arguments:
                      ConsultationModel.fromParent(_consultaions[i]).toJson(),
                );
              },
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(
                        _consultaions[i].title,
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      _buildBottomInfo(_consultaions[i]),
                    ],
                  ),
                ),
                leading: Icon(
                  Icons.inbox_outlined,
                  color: Colors.blue.shade900,
                  size: 26,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Row _buildBottomInfo(Consultation consultation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.access_time_rounded,
              color: Colors.grey,
              size: kSmallSize,
            ),
            const SizedBox(width: 2),
            Text(
              '${DateTime.now().difference(consultation.date).inDays} يوم',
              style: TextStyle(
                color: Colors.grey,
                fontSize: kSmallSize,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Wrap(
              spacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Icon(
                  Icons.medical_services_outlined,
                  color: Colors.grey,
                  size: kSmallSize,
                ),
                Text(
                  '${consultation.clinicSpecialization}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: kSmallSize,
                  ),
                ),
              ],
            ),
            Text(
              '  |  ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: kSmallSize,
              ),
            ),
            Wrap(
              spacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '${consultation.consResponse != null ? '1' : '0'}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: kSmallSize,
                  ),
                ),
                Text(
                  'تعليق',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: kSmallSize,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
