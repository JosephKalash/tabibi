import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/core/utils/widgets/loading_list.dart';
import 'package:tabibi/core/utils/widgets/top_edges-container.dart';
import 'package:tabibi/features/consultations/presentation/cubit/consultation_cubit.dart';
import 'package:tabibi/features/consultations/presentation/pages/add_consultations.dart';

import 'consultations_list.dart';

enum Kind { GetConsultation, GetMyCons }

class ConsultationsView extends StatefulWidget {
  final Kind _kind;

  const ConsultationsView(this._kind);

  @override
  _ConsultationsViewState createState() => _ConsultationsViewState();
}

class _ConsultationsViewState extends State<ConsultationsView> {
  bool _initWidget = true;
  @override
  void didChangeDependencies() {
    if (_initWidget) {
      _fetchConsultations();
      _initWidget = false;
    }
    super.didChangeDependencies();
  }

  void _fetchConsultations() {
    final cubit = BlocProvider.of<ConsultationCubit>(context);
    if (widget._kind == Kind.GetConsultation)
      cubit.getConsultations();
    else if (widget._kind == Kind.GetMyCons) cubit.getMyConsultation('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: TopEdgesContainer(
        child: BlocBuilder<ConsultationCubit, ConsultationState>(
          builder: (_, state) {
            if (state is Loading)
              return Center(child: LoadingListPage());
            else if (state is ErrorState)
              return Center(child: Text(state.message));
            else if (state is GotConsultations)
              return ConsultationsList(state.consultations);
            else if (state is GotMyConsultations)
              return ConsultationsList(state.consultations);
            else if (state is GotConsultationsBySpeci)
              return ConsultationsList(state.consultations);
            else
              return Center(child: Text('الرجاء التجربة لاحقا'));
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: widget._kind == Kind.GetMyCons
          ? FloatingActionButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue.shade900,
              onPressed: () {
                Navigator.of(context).pushNamed(AddConsultaionScreen.pathName);
              },
            )
          : null,
    );
  }
}
