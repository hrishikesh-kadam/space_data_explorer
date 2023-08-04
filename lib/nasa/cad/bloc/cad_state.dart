import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_state.freezed.dart';

enum NetworkState { initial, sending, success, failure }

enum SmallBodySelector {
  spkId(displayName: 'SPK-ID'),
  designation(displayName: 'Designation');

  const SmallBodySelector({required this.displayName});

  final String displayName;
}

@freezed
class CadState with _$CadState {
  factory CadState({
    DateTimeRange? dateRange,
    @Default(SbdbCadQueryParameters.defaultSmallBody) SmallBody smallBody,
    SmallBodySelector? smallBodySelector,
    int? spkId,
    String? designation,
    @Default(SbdbCadQueryParameters.defaultCloseApproachBody)
    CloseApproachBody closeApproachBody,
    @Default(NetworkState.initial) NetworkState networkState,
    SbdbCadBody? sbdbCadBody,
  }) = _CadState;
}
