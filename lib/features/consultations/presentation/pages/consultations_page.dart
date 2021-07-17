import 'package:flutter/material.dart';
import 'package:tabibi/features/consultations/presentation/pages/add_consultations.dart';
import 'package:tabibi/features/consultations/presentation/widgets/consultaions_view.dart';
import 'package:tabibi/features/consultations/presentation/widgets/consultations_list.dart';

class ConsultationsScreen extends StatelessWidget {
  static const pathName = '\consultations';

  final _kTabPages = <Widget>[
    ConsultationsList([], Kind.GetConsultation),
    ConsultationsView(Kind.GetMyCons),
  ];

  final _kTabs = <Tab>[
    Tab(child: Center(child: Text('الأستشارات', textAlign: TextAlign.center))),
    Tab(child: Center(child: Text('أستشاراتي', textAlign: TextAlign.center))),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: _kTabs,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: () {},
            ),
          ],
        ),
        body: TabBarView(children: _kTabPages),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue.shade900,
          onPressed: () {
            Navigator.of(context).pushNamed(AddConsultaionScreen.pathName);
          },
        ),
      ),
    );
  }
}
