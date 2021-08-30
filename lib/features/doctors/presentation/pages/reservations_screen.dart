import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/core/utils/widgets/top_edges-container.dart';
import 'package:tabibi/features/doctors/presentation/widgets/reservations_list.dart';
import 'package:tabibi/features/reservations/presentation/cubit/reservations_cubit.dart';

class ReservationsScreen extends StatefulWidget {
  static const routeName = '/reservations';

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  bool _initWidget = true;
  @override
  void didChangeDependencies() {
    if (_initWidget) {
      _fetchReservations();
      _initWidget = false;
    }
    super.didChangeDependencies();
  }

  void _fetchReservations() {
    final cubit = BlocProvider.of<ReservationsCubit>(context);
    cubit.getReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('الحجوزات'),
      ),
      body: TopEdgesContainer(
        topPadding: 24,
        child: BlocConsumer<ReservationsCubit, ReservationsState>(
          listener: (_, state) {
            if (state is CanceledReservation) {
              BlocProvider.of<ReservationsCubit>(context).getReservations();
              
              if (!state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: SizedBox(
                  height: 30,
                  child: Center(
                    child: Text('لم تنجح عملبة ألغاء الحجز جرب مرة اخرى'),
                  ),
                )));
              }
            }
          },
          builder: (_, state) {
            if (state is Loading)
              return Center(child: CircularProgressIndicator());
            else if (state is GotReservation)
              return ReservationsList(state.reservations);
            else if (state is ReservationError)
              return Center(child: Text(state.message));
            else
              return Center(child: Text('خطأ غير متوقع، جرب مرة اخرى'));
          },
        ),
      ),
    );
  }
}
