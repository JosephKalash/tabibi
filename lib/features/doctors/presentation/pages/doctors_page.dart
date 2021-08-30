import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/core/utils/widgets/top_edges-container.dart';

import '../cubit/doctors_cubit.dart';
import '../widgets/DoctorsGrid.dart';
import 'reservations_screen.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen>
    with AutomaticKeepAliveClientMixin {
  bool _initWidget = true;

  @override
  void didChangeDependencies() {
    if (_initWidget) {
      _fetchDoctors();
      _initWidget = false;
    }
    super.didChangeDependencies();
  }

  void _fetchDoctors() {
    final cubit = BlocProvider.of<DoctorsCubit>(context);
    cubit.getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('الأطباء'),
        actions: [
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              Navigator.of(context).pushNamed(ReservationsScreen.routeName);
            },
          ),
        ],
      ),
      body: TopEdgesContainer(
        topPadding: 24,
        child: RefreshIndicator(
          onRefresh: () async => _fetchDoctors(),
          child: BlocBuilder<DoctorsCubit, DoctorsState>(
            builder: (_, state) {
              if (state is Loading)
                return Center(child: CircularProgressIndicator());
              else if (state is GotDoctors)
                return DoctorsGrid(state.doctors);
              else if (state is DoctorError)
                return Center(child: Text(state.message));
              else
                return Center(child: Text('فشل في الأتصال بالمخدم'));
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
