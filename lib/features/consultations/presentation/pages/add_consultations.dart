import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tabibi/features/consultations/presentation/widgets/consultaions_view.dart'
    show Kind;
import '../../../../core/utils/constaints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/consultation_model.dart';
import '../cubit/consultation_cubit.dart';
import '../../../specializations/presentation/cubit/specializations_cubit.dart';

class AddConsultaionScreen extends StatefulWidget {
  static const pathName = '/addConsultaion';
  @override
  _AddConsultaionScreenState createState() => _AddConsultaionScreenState();
}

class _AddConsultaionScreenState extends State<AddConsultaionScreen> {
  final FocusNode _content = FocusNode();
  bool _initWidget = true;
  final _formKey = GlobalKey<FormState>();
  final _data = {
    kClinicSpecialization: '',
    kTitle: '',
    kContent: '',
  };
  Kind? _kind;
  @override
  void didChangeDependencies() {
    if (_initWidget) {
      final cubit = BlocProvider.of<SpecializationsCubit>(context);
      cubit.getSpecializations();
      _initWidget = false;
    }
    super.didChangeDependencies();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final consultation = ConsultationModel.fromJson(_data);
    final cubit = BlocProvider.of<ConsultationCubit>(context, listen: false);
    final state = cubit.state;
    if (state is GotMyConsultations)
      _kind = Kind.GetMyCons;
    else
      _kind = Kind.GetConsultation;

    cubit.addConsultation(consultation);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final cubit =
            BlocProvider.of<ConsultationCubit>(context, listen: false);
        if (_kind == Kind.GetMyCons)
          cubit.getMyConsultation('');
        else
          cubit.getConsultations();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('اضافة استشارة'),
        ),
        body: BlocBuilder<ConsultationCubit, ConsultationState>(
          builder: (_, state) {
            if (state is Loading)
              return Center(
                  child: ModalProgressHUD(
                inAsyncCall: true,
                child: SizedBox(),
              ));
            else if (state is AddedConsultation) {
              Navigator.of(context).pop();
              return SizedBox();
            } else if (state is ErrorState) {
              _snackbar(state);
              return SizedBox();
            } else
              return _buildForm(context);
          },
        ),
      ),
    );
  }

  Padding _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'المعلومات الشخصية سوف تبقى مجهولة وسرية ولن يتم نشرها ابدا',
            style: TextStyle(color: Colors.grey),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'اختر التخصص المناسب:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  BlocBuilder<SpecializationsCubit, SpecializationsState>(
                    builder: (_, state) {
                      if (state is GotSpecials)
                        return _buildDropdownSpecis(state);
                      else if (state is ErrorSpeciState)
                        return Text(
                          state.message,
                          style: TextStyle(fontSize: 12),
                        );
                      else
                        return _buildErrorDropdown();
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'العنوان',
                      hintText: 'ادخل عنوان للأستشارة',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'لا يمكن أن يكون العنوان فارغ';
                      else if (value.length < 12) return 'العنوان قصير جدا';
                      return null;
                    },
                    onSaved: (value) {
                      _data[kTitle] = value!;
                    },
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_content);
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    focusNode: _content,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'الوصف',
                      hintText:
                          'ادخل وصف للأستشارة تحوي المعلومات الطبية الخاصة بالمريض',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'لا يمكن أن يكون الوصف فارغ';
                      else if (value.length < 30) return 'الوصف قصير جدا';
                      return null;
                    },
                    onSaved: (value) {
                      _data[kContent] = value!;
                    },
                    onFieldSubmitted: (_) {
                      _submit();
                    },
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: Text('حفظ'),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue.shade900,
              elevation: 8,
            ),
          ),
        ],
      ),
    );
  }

  void _snackbar(ErrorState state) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(state.message)));
  }

  DropdownButtonFormField<void> _buildErrorDropdown() {
    return DropdownButtonFormField<void>(
      items: [],
      validator: (_) {
        return 'خطأ خلال الأتصال بالمخدم حاول مرة أخرى';
      },
    );
  }

  DropdownButtonFormField<String> _buildDropdownSpecis(GotSpecials state) {
    return DropdownButtonFormField<String>(
      items: _getSpecializations(state),
      hint: Text('اختر التخصص المناسب للحالة الطبية'),
      validator: (value) {
        if (value == null || value.isEmpty) return 'يجب أن تختار تخصص معين';
        return null;
      },
      onSaved: (value) {
        _data[kClinicSpecialization] = value!;
      },
    );
  }

  List<DropdownMenuItem<String>> _getSpecializations(GotSpecials state) {
    return state.speciaList
        .map(
          (e) => DropdownMenuItem(
            child: Text(e.name),
            value: e.value,
          ),
        )
        .toList();
  }
}
