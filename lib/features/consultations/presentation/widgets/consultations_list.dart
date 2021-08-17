import 'package:flutter/material.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';
import 'package:tabibi/features/consultations/domain/entities/consultation.dart';

class ConsultationsList extends StatelessWidget {
  final List<Consultation> consultaions;

  const ConsultationsList(this.consultaions);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final _consultaions = [
      ConsultationModel(
        'داخلية',
        'خرا عليك ةعلى يلي بدو يعيك شي',
        'content',
        date,
      ),
      ConsultationModel(
        'عصبية ظاخلية',
        'يا كلب كم كرة الوحد بظو يديب تالتال اتلاتلاتل لاتالتل اتللالتا ببببببببببببببببببببببببببببب بل بلبل  ل لتنيب قلك لترد لعماش',
        'content',
        date,
      ),
      ConsultationModel(
        'داخلية',
        'خرا عليك ةعلى يلي بدو يعيك شي',
        'content',
        date,
      ),
      ConsultationModel(
        'عصبية ظاخلية',
        'يا كلب كم كرة الوحد بظو يديب تنيب قلك لترد لعماش',
        'content',
        date,
      ),
      ConsultationModel(
        'داخلية',
        'خرا عليك ةعلى يلي بدو يعيك شي',
        'content',
        date,
      ),
      ConsultationModel(
        'عصبية ظاخلية',
        'يا كلب كم كرة الوحد بظو يديب تنيب قلك لترد لعماش',
        'content',
        date,
      ),
      ConsultationModel(
        'داخلية',
        'خرا عليك ةعلى يلي بدو يعيك شي',
        'content',
        date,
      ),
      ConsultationModel(
        'عصبية ظاخلية',
        'يا كلب كم كرة الوحد بظو يديب تنيب قلك لترد لعماش',
        'content',
        date,
      ),
    ];
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: _consultaions.length,
      clipBehavior: Clip.antiAlias,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () {},
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                _consultaions[i].title,
                maxLines: 3,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 14),
              ),
              trailing: Icon(
                Icons.inbox_outlined,
                color: Colors.blue.shade900,
                size: 24,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 6,
                    children: [
                      Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            _consultaions[i].date.day.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: kSmallSize,
                            ),
                          ),
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                            size: kSmallSize,
                          )
                        ],
                      ),
                      Wrap(
                        spacing: 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            _consultaions[i].clinicSpecialization,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: kSmallSize,
                            ),
                          ),
                          Icon(
                            Icons.medical_services_outlined,
                            color: Colors.grey,
                            size: kSmallSize,
                          )
                        ],
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 1,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'تعليق',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: kSmallSize,
                        ),
                      ),
                      Text(
                        '${_consultaions[i].consResponse != null ? '1' : '0'}',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: kSmallSize,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
