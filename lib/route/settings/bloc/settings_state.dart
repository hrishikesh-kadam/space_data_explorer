import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helper/helper.dart';
import '../date_format_pattern.dart';
import '../language.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required final Language language,
    @LocaleListJsonConverter() List<Locale>? systemLocales,
    required final DateFormatPattern dateFormatPattern,
    bool? isAnyDialogShown,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
