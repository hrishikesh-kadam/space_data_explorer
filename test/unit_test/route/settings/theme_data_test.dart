import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

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

    test('#{ThemeDataExt.themeDatas}', () {
      for (final ThemeData? themeData in ThemeDataExt.themeDatas) {
        testConverter(themeData, themeData?.name);
      }
    });

    test('throwsArgumentError', () {
      final ThemeData themeData = ThemeData.light();
      expect(() => converter.toJson(themeData), throwsArgumentError);
      const String themeName = 'invalidThemeName';
      expect(() => converter.fromJson(themeName), throwsArgumentError);
    });
  });

  group('ThemeDataExt Unit Test', () {
    group('getThemeDataDisplayName()', () {
      test('throwsArgumentError', () {
        expect(
          () => ThemeDataExt.getDisplayName(
            l10n: l10n,
            themeData: ThemeData.light(),
          ),
          throwsArgumentError,
        );
      });
    });
  });
}
