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
    this.sbdbCadApi = sbdbCadApi ?? SbdbCadApi();
    on<CadRequested>(_onCadRequested);
    on<CadDateRangeSelected>(_onCadDateRangeSelected);
    on<CadSmallBodySelected>(_onCadSmallBodySelected);
    on<CadCloseApproachBodySelected>(_onCadCloseApproachBodySelected);
  }

  final _log = Logger('$appNamePascalCase.CadBloc');
  @visibleForTesting
  late final SbdbCadApi sbdbCadApi;

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
      queryParameters = queryParameters.copyWithSmallBody(state.smallBody);
      if (state.closeApproachBody !=
          SbdbCadQueryParameters.defaultCloseApproachBody) {
        queryParameters = queryParameters.copyWith(
          body: state.closeApproachBody,
        );
      }
      Response<SbdbCadBody> response = await sbdbCadApi.get(
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
    if (event.smallBody == null) {
      emit(state.copyWith(smallBody: SbdbCadQueryParameters.defaultSmallBody));
    } else {
      emit(state.copyWith(smallBody: event.smallBody!));
    }
  }

  Future<void> _onCadCloseApproachBodySelected(
    CadCloseApproachBodySelected event,
    Emitter<CadState> emit,
  ) async {
    if (event.closeApproachBody == null) {
      emit(state.copyWith(
        closeApproachBody: SbdbCadQueryParameters.defaultCloseApproachBody,
      ));
    } else {
      emit(state.copyWith(closeApproachBody: event.closeApproachBody!));
    }
  }
}
