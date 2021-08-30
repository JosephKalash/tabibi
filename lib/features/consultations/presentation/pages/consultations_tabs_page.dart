import 'package:flutter/material.dart';

import '../widgets/consultaions_view.dart';

class ConsultationsTabsScreen extends StatelessWidget {
  static const routeName = '\consultations';

  final _kTabPages = <Widget>[
    ConsultationsView(Kind.GetConsultation),
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
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.transparent,
            tabs: _kTabs,
          ),
          
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: _kTabPages,
        ),
      ),
    );
  }
}
