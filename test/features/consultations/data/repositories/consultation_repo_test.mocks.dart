// Mocks generated by Mockito 5.0.7 from annotations
// in tabibi/test/features/consultations/data/repositories/consultation_repo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:tabibi/features/consultations/data/data%20sources/cons_ds.dart'
    as _i2;
import 'package:tabibi/features/consultations/domain/entities/consultation.dart'
    as _i4;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

/// A class which mocks [ConsultationDS].
///
/// See the documentation for Mockito's code generation for more information.
class MockConsultationDS extends _i1.Mock implements _i2.ConsultationDS {
  MockConsultationDS() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> addConsultation(_i4.Consultation? consultation) =>
      (super.noSuchMethod(Invocation.method(#addConsultation, [consultation]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
  @override
  _i3.Future<List<_i4.Consultation>> getConsultations() =>
      (super.noSuchMethod(Invocation.method(#getConsultations, []),
              returnValue:
                  Future<List<_i4.Consultation>>.value(<_i4.Consultation>[]))
          as _i3.Future<List<_i4.Consultation>>);
  @override
  _i3.Future<List<_i4.Consultation>> getMyConsultations(String? userId) =>
      (super.noSuchMethod(Invocation.method(#getMyConsultatioins, [userId]),
              returnValue:
                  Future<List<_i4.Consultation>>.value(<_i4.Consultation>[]))
          as _i3.Future<List<_i4.Consultation>>);
  @override
  _i3.Future<List<_i4.Consultation>> getConsultationsBySpeci(
          String? specialization) =>
      (super.noSuchMethod(
              Invocation.method(#getConsultationsBySpeci, [specialization]),
              returnValue:
                  Future<List<_i4.Consultation>>.value(<_i4.Consultation>[]))
          as _i3.Future<List<_i4.Consultation>>);
}