// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../constants/constants.dart';

part 'cad_event.dart';
part 'cad_state.dart';

class CadBloc extends Bloc<CadEvent, CadState> {
  CadBloc({
    SbdbCadApi? sbdbCadApi,
  }) : super(CadInitial()) {
    _sbdbCadApi = sbdbCadApi ?? SbdbCadApi();
    on<CadRequested>(_onCadRequested);
    on<CadDateRangeSelected>(_onCadDateRangeSelected);
  }

  final _log = Logger('$appNamePascalCase.CadBloc');
  late final SbdbCadApi _sbdbCadApi;
  DateTimeRange? _dateRange;

  Future<void> _onCadRequested(
    CadRequested event,
    Emitter<CadState> emit,
  ) async {
    emit(CadRequestSent());
    try {
      final queryParameters = SbdbCadQueryParameters();
      if (_dateRange != null) {
        queryParameters.dateMin = dateFormatter.format(_dateRange!.start);
        queryParameters.dateMax = dateFormatter.format(_dateRange!.end);
      }
      Response<SbdbCadBody> response = await _sbdbCadApi.get(
        queryParameters: queryParameters.toJson(),
      );
      _log.debug('_onCadRequested success');
      emit(CadRequestSuccess(sbdbCadBody: response.data!));
    } on Exception catch (e) {
      _log.error('_onCadRequested failed\n$e');
      emit(CadRequestFailure());
    }
  }

  Future<void> _onCadDateRangeSelected(
    CadDateRangeSelected event,
    Emitter<CadState> emit,
  ) async {
    _dateRange = event.dateRange;
  }
}
