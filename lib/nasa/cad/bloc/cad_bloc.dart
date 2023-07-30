import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../constants/constants.dart';
import 'cad_state.dart';

part 'cad_event.dart';

class CadBloc extends Bloc<CadEvent, CadState> {
  CadBloc({
    SbdbCadApi? sbdbCadApi,
  }) : super(CadState()) {
    _sbdbCadApi = sbdbCadApi ?? SbdbCadApi();
    on<CadRequested>(_onCadRequested);
    on<CadDateRangeSelected>(_onCadDateRangeSelected);
    on<CadSmallBodySelected>(_onCadSmallBodySelected);
  }

  final _log = Logger('$appNamePascalCase.CadBloc');
  late final SbdbCadApi _sbdbCadApi;

  Future<void> _onCadRequested(
    CadRequested event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(networkState: NetworkState.sending));
    try {
      SbdbCadQueryParameters queryParameters = SbdbCadQueryParameters();
      if (state.dateRange != null) {
        queryParameters = queryParameters.copyWith(
          dateMin: dateFormatter.format(state.dateRange!.start),
          dateMax: dateFormatter.format(state.dateRange!.end),
        );
      }
      switch (state.smallBody) {
        case SmallBody.pha:
          queryParameters = queryParameters.copyWith(pha: true);
        case SmallBody.nea:
          queryParameters = queryParameters.copyWith(nea: true);
        case SmallBody.comet:
          queryParameters = queryParameters.copyWith(comet: true);
        case SmallBody.neaComet:
          queryParameters = queryParameters.copyWith(neaComet: true);
        case SmallBody.neo:
          queryParameters = queryParameters.copyWith(nea: true);
        default:
      }
      Response<SbdbCadBody> response = await _sbdbCadApi.get(
        queryParameters: queryParameters.toJson(),
      );
      _log.fine('_onCadRequested success');
      emit(state.copyWith(
        networkState: NetworkState.success,
        sbdbCadBody: response.data,
      ));
    } on Exception catch (e, s) {
      _log.error('_onCadRequested failure', e, s);
      emit(state.copyWith(networkState: NetworkState.failure));
    }
  }

  Future<void> _onCadDateRangeSelected(
    CadDateRangeSelected event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(dateRange: event.dateRange));
  }

  Future<void> _onCadSmallBodySelected(
    CadSmallBodySelected event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(smallBody: event.smallBody));
  }
}
