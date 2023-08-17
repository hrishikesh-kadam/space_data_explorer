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
    CadState? initialState,
  }) : super(initialState ?? CadState.getInitial()) {
    this.sbdbCadApi = sbdbCadApi ?? SbdbCadApi();
    on<CadRequested>(_onCadRequested);
    on<CadDateRangeSelected>(_onCadDateRangeSelected);
    on<CadDistRangeEvent>(_onCadDistanceRangeEvent);
    on<CadSmallBodySelected>(_onCadSmallBodySelected);
    on<CadSmallBodySelectorEvent>(_onCadSmallBodySelectorEvent);
    on<CadCloseApproachBodySelected>(_onCadCloseApproachBodySelected);
    on<CadDataOutputEvent>(_onCadDataOutputEvent);
  }

  final _log = Logger('$appNamePascalCase.CadBloc');
  @visibleForTesting
  late final SbdbCadApi sbdbCadApi;

  Future<void> _onCadRequested(
    CadRequested event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(networkState: NetworkState.sending));
    SbdbCadQueryParameters queryParameters = const SbdbCadQueryParameters();
    if (state.dateRange != null) {
      queryParameters = queryParameters.copyWithDateRange(
        state.dateRange!.start,
        state.dateRange!.end,
      );
    }
    queryParameters = queryParameters.copyWithDistRange(
      state.distRange,
    );
    queryParameters = queryParameters.copyWithSmallBody(state.smallBody);
    if (state.smallBodySelector != null) {
      queryParameters = queryParameters.copyWithSmallBodySelector(
        state.smallBodySelector!,
        spkId: state.spkId,
        desgination: state.designation,
      );
    }
    if (state.closeApproachBody !=
        SbdbCadQueryParameters.closeApproachBodyDefault) {
      queryParameters = queryParameters.copyWith(
        body: state.closeApproachBody,
      );
    }
    queryParameters = queryParameters.copyWithDataOutput(state.dataOutputSet);
    try {
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

  Future<void> _onCadDistanceRangeEvent(
    CadDistRangeEvent event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      distRange: event.distRange,
      distRangeText: event.distRangeText,
    ));
  }

  Future<void> _onCadSmallBodySelected(
    CadSmallBodySelected event,
    Emitter<CadState> emit,
  ) async {
    if (event.smallBody == null) {
      emit(state.copyWith(smallBody: SbdbCadQueryParameters.smallBodyDefault));
    } else {
      emit(state.copyWith(smallBody: event.smallBody!));
    }
  }

  Future<void> _onCadSmallBodySelectorEvent(
    CadSmallBodySelectorEvent event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      smallBodySelector: event.smallBodySelector,
      spkId: event.spkId,
      designation: event.designation,
    ));
  }

  Future<void> _onCadCloseApproachBodySelected(
    CadCloseApproachBodySelected event,
    Emitter<CadState> emit,
  ) async {
    if (event.closeApproachBody == null) {
      emit(state.copyWith(
        closeApproachBody: SbdbCadQueryParameters.closeApproachBodyDefault,
      ));
    } else {
      emit(state.copyWith(closeApproachBody: event.closeApproachBody!));
    }
  }

  Future<void> _onCadDataOutputEvent(
    CadDataOutputEvent event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      dataOutputSet: event.dataOutputSet,
    ));
  }
}
