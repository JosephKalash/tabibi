import 'package:flutter/material.dart';

class AppScreen extends StatefulWidget {
  static const pathName = '/app';
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  static const _tabPages = <Widget>[
    Center(child: Icon(Icons.home_outlined)),
  ];

  static const _tabs = <Tab>[
    Tab(icon: Icon(Icons.home_outlined), text: 'tab1'),
    Tab(icon: Icon(Icons.local_hospital_outlined), text: 'tab2'),
    Tab(icon: Icon(Icons.ballot_outlined), text: 'tab3'),
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
      bottomNavigationBar: TabBar(
        tabs: _tabs,
        controller: _tabController,
      ),
    );
  }
}
