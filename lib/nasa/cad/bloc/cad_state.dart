import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_state.freezed.dart';

@freezed
class CadState with _$CadState {
  const factory CadState({
    DateTimeRange? dateRange,
    @Default(distRangeDefault) DistanceRange distRange,
    @Default(ValueRange<String, Never>(
      start: ValueUnit<String, Never>(value: ''),
      end: ValueUnit<String, Never>(value: ''),
    ))
    ValueRange<String, Never> distRangeText,
    @Default(SmallBodyFilterState()) SmallBodyFilterState smallBodyFilterState,
    @Default(SmallBodySelectorState())
    SmallBodySelectorState smallBodySelectorState,
    @Default(SbdbCadQueryParameters.closeApproachBodyDefault)
    CloseApproachBody closeApproachBody,
    @Default({}) Set<DataOutput> dataOutputSet,
    @Default(NetworkState.initial) NetworkState networkState,
    @Default(false) bool disableInputs,
    SbdbCadBody? sbdbCadBody,
  }) = _CadState;

  static CadState getInitial() {
    return const CadState().copyWith(
      distRangeText: distRangeTextDefault.copyWith(
        start: minDistTextDefault,
        end: maxDistTextDefault,
      ),
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

const minDistDefault = Distance(
  unit: SbdbCadQueryParameters.distUnitDefault,
);
const maxDistDefault = SbdbCadQueryParameters.distMaxDefault;
const distRangeDefault = DistanceRange(
  start: minDistDefault,
  end: maxDistDefault,
);
final minDistTextDefault = ValueUnit<String, Never>(
  value: minDistDefault.value?.toString() ?? '',
);
final maxDistTextDefault = ValueUnit<String, Never>(
  value: maxDistDefault.value?.toString() ?? '',
);
final distRangeTextDefault = ValueRange<String, Never>(
  start: minDistTextDefault,
  end: maxDistTextDefault,
);
