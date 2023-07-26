import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_state.freezed.dart';

enum NetworkState { initial, sent, success, failure }

@freezed
class CadState with _$CadState {
  factory CadState({
    DateTimeRange? dateRange,
    @Default(NetworkState.initial) NetworkState networkState,
    SbdbCadBody? sbdbCadBody,
  }) = _CadState;
}
