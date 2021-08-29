import 'package:flutter/material.dart';

import 'features/consultations/presentation/pages/consultations_tabs_page.dart';
import 'features/doctors/presentation/pages/doctors_page.dart';
import 'features/userProfile/presentation/pages/user_profile.dart';

class AppScreen extends StatefulWidget {
  static const routeName = '/app';
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final _tabPages = <Widget>[
    UserProfileScreen(),
    DoctorsScreen(),
    ConsultationsTabsScreen(),
  ];

  final _tabs = <Tab>[
    Tab(child: Icon(Icons.person_outline, color: Colors.blue.shade900)),
    Tab(
        child:
            Icon(Icons.local_hospital_outlined, color: Colors.blue.shade900)),
    Tab(child: Icon(Icons.ballot_outlined, color: Colors.blue.shade900)),
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: _tabPages.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _tabPages,
      ),
      bottomNavigationBar: SizedBox(
        height: 44,
        child: TabBar(
          tabs: _tabs,
          controller: _tabController,
        ),
      ),
    );
  }
}
