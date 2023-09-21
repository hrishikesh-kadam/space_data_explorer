// ignore_for_file: directives_ordering

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../../../extension/logger.dart';
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
    on<CadDistanceEvent>(_onCadDistanceEvent);
    on<CadSmallBodyFilterSelected>(_onCadSmallBodyFilterSelected);
    on<CadSmallBodySelectorEvent>(_onCadSmallBodySelectorEvent);
    on<CadCloseApproachBodySelected>(_onCadCloseApproachBodySelected);
    on<CadDataOutputEvent>(_onCadDataOutputEvent);
  }

  final _logger = Logger('$appNamePascalCase.CadBloc');
  @visibleForTesting
  late final SbdbCadApi sbdbCadApi;
  final String dioRequestCancelled = 'Dio Request Cancelled';

  @override
  Future<void> close() async {
    _logger.fine('close');
    if (state.cancelToken != null) {
      _logger.fine('close -> cancelToken.cancel()');
      state.cancelToken!.cancel(dioRequestCancelled);
    }
    super.close();
  }

  Future<void> _onCadRequested(
    CadRequested event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      networkState: NetworkState.preparing,
      disableInputs: true,
      error: null,
    ));
    SbdbCadQueryParameters queryParameters = const SbdbCadQueryParameters();
    if (state.dateRange != null) {
      queryParameters = queryParameters.copyWithDateRange(
        state.dateRange!.start,
        state.dateRange!.end,
      );
    }
    final Distance? distMin = constructDistance(
      value: state.distanceRangeState.valueList[0],
      unit: state.distanceRangeState.unitList[0],
    );
    final Distance? distMax = constructDistance(
      value: state.distanceRangeState.valueList[1],
      unit: state.distanceRangeState.unitList[1],
    );
    queryParameters = queryParameters.copyWithDistanceRange(distMin, distMax);
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
    final CancelToken cancelToken = CancelToken();
    emit(state.copyWith(
      networkState: NetworkState.sending,
      cancelToken: cancelToken,
    ));
    try {
      Response<SbdbCadBody> response = await sbdbCadApi.get(
        queryParameters: queryParameters.toJson(),
        cancelToken: cancelToken,
      );
      // await Future.delayed(const Duration(seconds: 5));
      _logger.fine('_onCadRequested success');
      emit(state.copyWith(
        networkState: NetworkState.success,
        cancelToken: null,
        sbdbCadBody: response.data,
      ));
    } catch (error, stackTrace) {
      bool? skipReportError;
      if (error is DioException && error.error == dioRequestCancelled) {
        skipReportError = true;
      }
      if (skipReportError != true) {
        _logger.reportError(
          '_onCadRequested failure',
          error: error,
          stackTrace: stackTrace,
          information: [queryParameters],
        );
      }
      emit(state.copyWith(
        networkState: NetworkState.failure,
        cancelToken: null,
        disableInputs: false,
        error: error,
      ));
    }
  }

  static Distance? constructDistance({
    required double? value,
    required DistanceUnit unit,
  }) {
    if (value != null) {
      return Distance(value: value, unit: unit);
    }
    return null;
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

  Future<void> _onCadDistanceEvent(
    CadDistanceEvent event,
    Emitter<CadState> emit,
  ) async {
    emit(state.copyWith(
      distanceRangeState: DistanceRangeState(
        valueList: event.valueList,
        textList: event.textList,
        unitList: event.unitList,
      ),
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
