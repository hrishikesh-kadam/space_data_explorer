import 'package:flutter/scheduler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    AppLifecycleState? appLifecycleState,
  }) = _AppState;
}
