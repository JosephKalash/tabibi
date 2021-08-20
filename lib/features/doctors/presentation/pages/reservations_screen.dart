import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/features/doctors/presentation/widgets/reservations_list.dart';
import 'package:tabibi/features/reservations/presentation/cubit/reservations_cubit.dart';

class ReservationsScreen extends StatefulWidget {
  static const pathName = '/reservations';

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الحجوزات'),
      ),
      body: BlocBuilder<ReservationsCubit, ReservationsState>(
        builder: (_, state) {
          if (state is Loading)
            return CircularProgressIndicator();
          else if (state is GotReservation)
            return ReservationsList(state.reservations);
          else if (state is ReservationError)
            return Center(child: Text(state.message));
          else
            return Center(child: Text('خطأ غير متوقع, جرب مرة اخرى'));
        },
      ),
    );
  }
}
