import 'package:flutter/material.dart';
import 'package:tabibi/core/utils/constaints.dart';
import 'package:tabibi/features/consultations/data/models/consultation_model.dart';

class DisplayConsultationScreen extends StatelessWidget {
  static const routeName = '/display_constultation';

  @override
  Widget build(BuildContext context) {
    final dataMap =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final _consultation = ConsultationModel.fromJson(dataMap);
    // final _consultation = ConsultationModel(
    //   'داخلية',
    //   'title',
    //   'ينتبم يتب منتي تينب ت يت ت ثهتبن يب منتيبت تب نشمتسي تيبن تشسينتب تينب',
    //   DateTime.now(),
    //   consResponse: ConsResponseModel(
    //     'نعم عزيزي عزية تنdfdf df dsf d fsd  sdf sبت ث تمثنم بت ابنب ثبة ثب',
    //     'د.عبد الفتاح السيسي',
    //     DateTime.now(),
    //   ),
    // );

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        title: Text('الاستشارة'),
      ),
      body: Container(
        color: Colors.transparent,
        height: double.infinity,
        padding: EdgeInsets.only(top: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 22),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                '${DateTime.now().difference(_consultation.date).inDays} يوم',
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
                            size: 28,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          _consultation.content,
                          style: TextStyle(fontSize: 16),
                        ),
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
                SizedBox(height: 10),
                Container(
                  width: 370,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueGrey.shade500,
                  ),
                  child: SizedBox(),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  constraints: BoxConstraints(minHeight: 60),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: _consultation.consResponse == null
                        ? Text('لا يوجد رد بعد')
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_consultation.consResponse?.doctorName),
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
                                        '${DateTime.now().difference(_consultation.consResponse!.date).inDays} يوم',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: kSmallSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(_consultation.consResponse?.response),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'لن يتم أظهار المعلومات الشخصية ضمن اي استشارة منشورة للعامة',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.red.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
