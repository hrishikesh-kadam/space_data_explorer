// ignore_for_file: directives_ordering

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../globals.dart';
import 'cad_state.dart';

part 'cad_event.dart';

class CadBloc extends Bloc<CadEvent, CadState> {
  CadBloc({
    SbdbCadApi? sbdbCadApi,
    CadState? initialState,
  }) : super(initialState ?? CadState.getInitial()) {
    this.sbdbCadApi = sbdbCadApi ?? SbdbCadApi();
    on<CadRequested>(_onCadRequested);
    on<CadResultOpened>(_onCadResultOpened);
    on<CadDateRangeSelected>(_onCadDateRangeSelected);
    on<CadDistRangeEvent>(_onCadDistanceRangeEvent);
    on<CadSmallBodyFilterSelected>(_onCadSmallBodyFilterSelected);
    on<CadSmallBodySelectorEvent>(_onCadSmallBodySelectorEvent);
    on<CadCloseApproachBodySelected>(_onCadCloseApproachBodySelected);
    on<CadDataOutputEvent>(_onCadDataOutputEvent);
  }

  final _logger = Logger('$appNamePascalCase.CadBloc');
  @visibleForTesting
  late final SbdbCadApi sbdbCadApi;

  Future<void> _onCadRequested(
    CadRequested event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      networkState: NetworkState.preparing,
      disableInputs: true,
    ));
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
    if (state.smallBodyFilterState.enabled) {
      queryParameters = queryParameters.copyWithSmallBodyFilter(
        state.smallBodyFilterState.smallBodyFilter,
      );
    } else if (state.smallBodySelectorState.smallBodySelector != null) {
      queryParameters = queryParameters.copyWithSmallBodySelector(
        state.smallBodySelectorState.smallBodySelector!,
        spkId: state.smallBodySelectorState.spkId,
        desgination: state.smallBodySelectorState.designation,
      );
    }
    if (state.closeApproachBody !=
        SbdbCadQueryParameters.closeApproachBodyDefault) {
      queryParameters = queryParameters.copyWith(
        body: state.closeApproachBody,
      );
    }
    queryParameters = queryParameters.copyWithDataOutput(state.dataOutputSet);
    emit(state.copyWith(networkState: NetworkState.sending));
    try {
      Response<SbdbCadBody> response = await sbdbCadApi.get(
        queryParameters: queryParameters.toJson(),
      );
      // await Future.delayed(const Duration(seconds: 5));
      _logger.fine('_onCadRequested success');
      emit(state.copyWith(
        networkState: NetworkState.success,
        sbdbCadBody: response.data,
      ));
    } on Exception catch (e, s) {
      _logger.error('_onCadRequested failure', e, s);
      emit(state.copyWith(
        networkState: NetworkState.failure,
        disableInputs: false,
      ));
      FirebaseCrashlytics.instance.recordError(e, s,
          reason: '_onCadRequested failure',
          information: [queryParameters],
          printDetails: false);
    }
  }

  Future<void> _onCadResultOpened(
    CadResultOpened event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(disableInputs: false));
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

  Future<void> _onCadSmallBodyFilterSelected(
    CadSmallBodyFilterSelected event,
    Emitter<CadState> emit,
  ) async {
    if (event.smallBodyFilter == null) {
      emit(state.copyWith(
        smallBodyFilterState: state.smallBodyFilterState.copyWith(
          smallBodyFilter: SbdbCadQueryParameters.smallBodyFilterDefault,
        ),
      ));
    } else {
      emit(state.copyWith(
        smallBodyFilterState: state.smallBodyFilterState.copyWith(
          smallBodyFilter: event.smallBodyFilter!,
        ),
      ));
    }
  }

  Future<void> _onCadSmallBodySelectorEvent(
    CadSmallBodySelectorEvent event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      smallBodyFilterState: state.smallBodyFilterState.copyWith(
        enabled: event.smallBodySelectorState.smallBodySelector == null,
      ),
      smallBodySelectorState: event.smallBodySelectorState,
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
