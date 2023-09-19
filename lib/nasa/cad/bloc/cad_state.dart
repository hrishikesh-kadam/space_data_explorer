import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_state.freezed.dart';

@freezed
class CadState with _$CadState {
  const factory CadState({
    DateTimeRange? dateRange,
    @Default(DistanceRangeState()) DistanceRangeState distanceRangeState,
    @Default(SmallBodyFilterState()) SmallBodyFilterState smallBodyFilterState,
    @Default(SmallBodySelectorState())
    SmallBodySelectorState smallBodySelectorState,
    @Default(SbdbCadQueryParameters.closeApproachBodyDefault)
    CloseApproachBody closeApproachBody,
    @Default({}) Set<DataOutput> dataOutputSet,
    @Default(NetworkState.initial) NetworkState networkState,
    @Default(false) bool disableInputs,
    SbdbCadBody? sbdbCadBody,
    Object? error,
  }) = _CadState;

  static CadState getInitial() {
    return const CadState().copyWith(
      distanceRangeState: DistanceRangeState.getInitial(),
    );
  }
}

@freezed
class DistanceRangeState with _$DistanceRangeState {
  const factory DistanceRangeState({
    @Default([]) List<double?> valueList,
    @Default([]) List<String> textList,
    @Default([]) List<DistanceUnit> unitList,
  }) = _DistanceRangeState;

  static const Distance? distMinDefault = null;
  // ignore: unnecessary_nullable_for_final_variable_declarations
  static const Distance? distMaxDefault = SbdbCadQueryParameters.distMaxDefault;
  static final List<double?> valueListDefault = [
    distMinDefault?.value,
    distMaxDefault?.value,
  ];
  static final List<String> textListDefault = [
    distMinDefault?.value.toString() ?? '',
    distMaxDefault?.value.toString() ?? '',
  ];
  static final List<DistanceUnit> unitListDefault = [
    distMinDefault?.unit ?? SbdbCadQueryParameters.distUnitDefault,
    distMaxDefault?.unit ?? SbdbCadQueryParameters.distUnitDefault,
  ];
  static DistanceRangeState getInitial() {
    return const DistanceRangeState().copyWith(
      valueList: valueListDefault,
      textList: textListDefault,
      unitList: unitListDefault,
    );
  }
}

@freezed
class SmallBodyFilterState with _$SmallBodyFilterState {
  const factory SmallBodyFilterState({
    @Default(true) bool enabled,
    @Default(SbdbCadQueryParameters.smallBodyFilterDefault)
    SmallBodyFilter smallBodyFilter,
  }) = _SmallBodyFilterState;
}

@freezed
class SmallBodySelectorState with _$SmallBodySelectorState {
  const factory SmallBodySelectorState({
    SmallBodySelector? smallBodySelector,
    int? spkId,
    String? designation,
  }) = _SmallBodySelectorState;
}

enum NetworkState {
  initial,
  preparing,
  sending,
  success,
  failure,
}
