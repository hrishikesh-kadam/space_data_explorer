import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

part 'cad_state.freezed.dart';

enum NetworkState { initial, sending, success, failure }

enum SmallBody {
  pha(displayName: 'PHA'),
  nea(displayName: 'NEA'),
  comet(displayName: 'Comet'),
  neaComet(displayName: 'NEA and Comet'),
  neo(displayName: 'NEO');

  const SmallBody({required this.displayName});

  final String displayName;
}

@freezed
class CadState with _$CadState {
  static const defaultSmallBody = SmallBody.neo;

  factory CadState({
    DateTimeRange? dateRange,
    @Default(CadState.defaultSmallBody) SmallBody smallBody,
    @Default(NetworkState.initial) NetworkState networkState,
    SbdbCadBody? sbdbCadBody,
  }) = _CadState;
}
