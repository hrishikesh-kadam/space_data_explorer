import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/route/settings/theme_data.dart';
import '../../../src/globals.dart';

void main() {
  group('ThemeDataJsonConverter Unit Test', () {
    const converter = ThemeDataJsonConverter();

    void testConverter(ThemeData? themeData, String? themeName) {
      final String? convertedString = converter.toJson(themeData);
      expect(convertedString, themeName);
      final ThemeData? roundTripThemeData = converter.fromJson(convertedString);
      expect(roundTripThemeData, themeData);
      final ThemeData? convertedThemeData = converter.fromJson(themeName);
      expect(convertedThemeData, themeData);
      final String? roundTripString = converter.toJson(convertedThemeData);
      expect(roundTripString, themeName);
    }

    test('#{SettingsScreen.themeDatas}', () {
      final List<String?> themeNames = [
        ThemeDataExt.systemThemeModePreferredName,
        ThemeDataExt.defaultBrightName,
        ThemeDataExt.defaultDarkName,
        ThemeDataExt.spaceName,
      ];
      expect(SettingsScreen.themeDatas.length, themeNames.length);
      for (final (i, themeData) in SettingsScreen.themeDatas.indexed) {
        final String? themeName = themeNames[i];
        testConverter(themeData, themeName);
      }
    });

    test('throwsArgumentError', () {
      final ThemeData themeData = ThemeData.light();
      expect(() => converter.toJson(themeData), throwsArgumentError);
      const String themeName = 'invalidThemeName';
      expect(() => converter.fromJson(themeName), throwsArgumentError);
    });
  });

  group('getThemeDataValueTitle()', () {
    test('throwsArgumentError', () {
      expect(
        () => SettingsScreen.getThemeDataValueTitle(
          l10n: l10n,
          themeData: ThemeData.light(),
        ),
        throwsArgumentError,
      );
    });
  });
}
