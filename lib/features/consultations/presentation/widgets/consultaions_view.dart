import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabibi/features/consultations/presentation/cubit/consultation_cubit.dart';

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
    return BlocBuilder<ConsultationCubit, ConsultationState>(
      builder: (_, state) {
        if (state is Loading)
          return CircularProgressIndicator();
        else if (state is ErrorState)
          return Center(child: Text(state.message));
        else if (state is GotConsultations)
          return ConsultationsList(state.consultations,widget._kind);
        else if(state is GotMyConsultations)
          return ConsultationsList(state.consultations,widget._kind);
        else if(state is GotConsultationsBySpeci)
          return ConsultationsList(state.consultations,widget._kind);
        else
          return Center(
            child: Text('الرجاء التجربة لاحقا')
          );
      },
    );
  }
}
