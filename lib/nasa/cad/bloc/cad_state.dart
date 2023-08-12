import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_state.freezed.dart';

@freezed
class CadState with _$CadState {
  const factory CadState({
    DateTimeRange? dateRange,
    @Default(defaultDistanceRange) DistanceRange distanceRange,
    @Default(ValueRange<String, void>(
      start: minDistTextDefault,
      end: ValueUnit<String, void>(value: ''),
    ))
    ValueRange<String, void> distanceTextRange,
    @Default(SbdbCadQueryParameters.defaultSmallBody) SmallBody smallBody,
    SmallBodySelector? smallBodySelector,
    int? spkId,
    String? designation,
    @Default(SbdbCadQueryParameters.defaultCloseApproachBody)
    CloseApproachBody closeApproachBody,
    @Default({}) Set<DataOutput> dataOutputSet,
    @Default(NetworkState.initial) NetworkState networkState,
    SbdbCadBody? sbdbCadBody,
  }) = _CadState;

  static CadState getInitial() {
    return const CadState().copyWith(
      distanceTextRange: defaultDistaceTextRange.copyWith(
        end: maxDistTextDefault,
      ),
    );
  }
}

enum NetworkState { initial, sending, success, failure }

const minDistDefault = Distance(
  unit: SbdbCadQueryParameters.defaultDistanceUnit,
);
const maxDistDefault = SbdbCadQueryParameters.defaultDistMax;
const defaultDistanceRange = DistanceRange(
  start: minDistDefault,
  end: maxDistDefault,
);
const minDistTextDefault = ValueUnit<String, void>(value: '');
final maxDistTextDefault = ValueUnit<String, void>(
  value: maxDistDefault.value?.toString() ?? '',
);
final defaultDistaceTextRange = ValueRange<String, void>(
  start: minDistTextDefault,
  end: maxDistTextDefault,
);
