import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_state.freezed.dart';

enum NetworkState { initial, sending, success, failure }

@freezed
class CadState with _$CadState {
  const factory CadState({
    DateTimeRange? dateRange,
    @Default(DistanceRange(
      start: Distance(
        unit: SbdbCadQueryParameters.defaultDistanceUnit,
      ),
      end: SbdbCadQueryParameters.defaultDistMax,
    ))
    DistanceRange distanceRange,
    @Default(ValueRange<String, void>(
      start: ValueUnit<String, void>(),
      end: ValueUnit<String, void>(),
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
}
