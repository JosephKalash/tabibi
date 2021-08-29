import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabibi/features/authentication/presentation/cubit/auth_cubit.dart'
    as auth;
import '../../../../core/utils/constaints.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/consultation_model.dart';
import '../cubit/consultation_cubit.dart';
import '../../../specializations/presentation/cubit/specializations_cubit.dart';

class AddConsultaionScreen extends StatefulWidget {
  static const routeName = '/addConsultaion';
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
    kUserAge: 0,
  };

  @override
  void didChangeDependencies() {
    if (_initWidget) {
      final cubit = BlocProvider.of<SpecializationsCubit>(context);
      cubit.getSpecializations();
      _initWidget = false;
    }
    super.didChangeDependencies();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final preferences = await SharedPreferences.getInstance();
    final map = json.decode(preferences.getString(kPersonInfoPref) ?? '');

    _data[kUserAge] = map[kUserAge] ?? 0;

    final consultation = ConsultationModel.fromJson(_data);

    final cubit = BlocProvider.of<ConsultationCubit>(context);
    cubit.addConsultation(consultation);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final cubit =
            BlocProvider.of<ConsultationCubit>(context, listen: false);
        cubit.getMyConsultation('');
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          elevation: 0,
          title: Text('اضافة استشارة'),
        ),
        body: Stack(
          children: [
            BlocConsumer<ConsultationCubit, ConsultationState>(
              listener: (_, state) {
                if (state is AddedConsultation)
                  Navigator.of(context).pop();
                else if (state is ErrorState) _snackbar(state.message);
              },
              builder: (_, state) {
                if (state is Loading)
                  return Center(
                      child: ModalProgressHUD(
                    inAsyncCall: true,
                    child: SizedBox(),
                  ));

                return SizedBox();
              },
            ),
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'المعلومات الشخصية سوف تبقى مجهولة وسرية ولن يتم نشرها ابدا',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 25),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            else if (state is LoadingSpci)
                              return LinearProgressIndicator();
                            return _buildErrorDropdown();
                          },
                        ),
                        SizedBox(height: 28),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'العنوان',
                            hintText: 'ادخل عنوان للأستشارة',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'لا يمكن أن يكون العنوان فارغ';
                            else if (value.length < 12)
                              return 'العنوان قصير جدا';
                            return null;
                          },
                          onSaved: (value) {
                            _data[kTitle] = value!;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_content);
                          },
                        ),
                        SizedBox(height: 28),
                        TextFormField(
                          focusNode: _content,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'الوصف',
                            hintText:
                                'ادخل وصف للأستشارة تحوي المعلومات الطبية الخاصة بالمريض والأعراض التي يعاني منها',
                          ),
                          maxLines: 5,
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
              ),
              ElevatedButton(
                onPressed: _submit,
                child: Text('حفظ'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.shade900,
                  elevation: 4,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _snackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  DropdownButtonFormField<void> _buildErrorDropdown() {
    return DropdownButtonFormField<void>(
      items: [],
      hint: Text('خطأ خلال الأتصال بالمخدم حاول مرة أخرى'),
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
            child: Text(e.id),
            value: e.name,
          ),
        )
        .toList();
  }
}
