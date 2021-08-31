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
  bool _filter = false;
  dynamic? _filterValue;
  Set<dynamic>? _list;

  @override
  void didChangeDependencies() {
    if (_initWidget) {
      _fetchDoctors();
      _initWidget = false;
    }
    super.didChangeDependencies();
  }

  void _fetchDoctors() {
    _filterValue = null;
    _filter = false;
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
          IconButton(
              icon: Icon(Icons.filter_alt_outlined),
              onPressed: () async {
                if (!_filter) return;
                _filterValue = await _showDialoge(context, _list!);

                setState(() {});
              }),
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
              else if (state is GotDoctors) {
                _list = state.doctors.map((e) => e.specialization).toSet();
                _filter = true;
                return DoctorsGrid(
                  state.doctors,
                  filterSpci: _filterValue,
                );
              } else if (state is DoctorError)
                return Center(child: Text(state.message));
              else
                return Center(child: Text('فشل في الأتصال بالمخدم'));
            },
          ),
        ),
      ),
    );
  }

  Future _showDialoge(context, Set<dynamic> list) async {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'اختر تخصص',
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            Wrap(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(null);
                  },
                  child: Text('لا شيئ'),
                ),
                ...list
                    .map((e) => TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(e);
                          },
                          child: Text(e.toString()),
                        ))
                    .toList()
              ],
            )
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
