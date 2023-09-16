import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import '../../../helper/helper.dart';
import '../date_format_pattern.dart';
import '../time_format_pattern.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@freezed
class SettingsState with _$SettingsState {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory SettingsState({
    @LocaleJsonConverter() Locale? locale,
    @LocaleListJsonConverter() List<Locale>? systemLocales,
    @Default(DateFormatPattern.yMd) DateFormatPattern dateFormatPattern,
    @Default(TimeFormatPattern.jm) TimeFormatPattern timeFormatPattern,
    @Default(DistanceUnit.au) DistanceUnit distanceUnit,
    @Default(VelocityUnit.kmps) VelocityUnit velocityUnit,
    TextDirection? textDirection,
    bool? isAnyDialogShown,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
