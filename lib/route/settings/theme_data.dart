import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

extension ThemeDataExt on ThemeData {
  static const ThemeData? systemThemeModePreferred = null;
  static const String? systemThemeModePreferredName = null;

  static const String defaultBrightName = 'defaultBright';
  static final ThemeData defaultBright = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
    ),
    useMaterial3: true,
  );

  static const String defaultDarkName = 'defaultDark';
  static final ThemeData defaultDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );

  static const String spaceName = 'space';
  static final ThemeData space = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
  );
}

class ThemeDataJsonConverter implements JsonConverter<ThemeData?, String?> {
  const ThemeDataJsonConverter();

  @override
  ThemeData? fromJson(String? themeName) {
    if (themeName == ThemeDataExt.systemThemeModePreferredName) {
      return ThemeDataExt.systemThemeModePreferred;
    } else if (themeName == ThemeDataExt.defaultBrightName) {
      return ThemeDataExt.defaultBright;
    } else if (themeName == ThemeDataExt.defaultDarkName) {
      return ThemeDataExt.defaultDark;
    } else if (themeName == ThemeDataExt.spaceName) {
      return ThemeDataExt.space;
    } else {
      throw ArgumentError.value(themeName, 'string', 'Not serialized');
    }
  }

  @override
  String? toJson(ThemeData? themeData) {
    if (themeData == ThemeDataExt.systemThemeModePreferred) {
      return ThemeDataExt.systemThemeModePreferredName;
    } else if (themeData == ThemeDataExt.defaultBright) {
      return ThemeDataExt.defaultBrightName;
    } else if (themeData == ThemeDataExt.defaultDark) {
      return ThemeDataExt.defaultDarkName;
    } else if (themeData == ThemeDataExt.space) {
      return ThemeDataExt.spaceName;
    } else {
      throw ArgumentError.value(themeData, 'object', 'Not serialized');
    }
  }
}
