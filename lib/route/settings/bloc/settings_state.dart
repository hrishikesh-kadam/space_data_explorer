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
    @Default(SettingsState.localeDefault) @LocaleJsonConverter() Locale? locale,
    @LocaleListJsonConverter() List<Locale>? systemLocales,
    @Default(SettingsState.dateFormatPatternDefault)
    DateFormatPattern dateFormatPattern,
    @Default(SettingsState.timeFormatPatternDefault)
    TimeFormatPattern timeFormatPattern,
    @Default(SettingsState.textDirectionDefault) TextDirection? textDirection,
    @Default(SettingsState.distanceUnitDefault) DistanceUnit distanceUnit,
    @Default(SettingsState.velocityUnitDefault) VelocityUnit velocityUnit,
    @Default(SettingsState.diameterUnitDefault) DistanceUnit diameterUnit,
    bool? isAnyDialogShown,
  }) = _SettingsState;

  static const Locale? localeDefault = null;
  static const DateFormatPattern dateFormatPatternDefault =
      DateFormatPattern.yMd;
  static const TimeFormatPattern timeFormatPatternDefault =
      TimeFormatPattern.jm;
  static const TextDirection? textDirectionDefault = null;
  static const DistanceUnit distanceUnitDefault = DistanceUnit.au;
  static const VelocityUnit velocityUnitDefault = VelocityUnit.kmps;
  static const DistanceUnit diameterUnitDefault = DistanceUnit.km;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
