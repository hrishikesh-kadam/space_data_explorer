// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';

import 'package:checks/checks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';
import 'package:hrk_test_batteries/hrk_test_batteries.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

import 'package:space_data_explorer/route/settings/theme/custom_theme.dart';

void main() {
  group('$CustomTheme Unit Test', () {
    group('buildDynamicScheme()', () {
      test('secondaryColor', () {
        final DynamicScheme s1 = CustomTheme.buildDynamicScheme();
        final DynamicScheme s2 = CustomTheme.buildDynamicScheme(
          secondaryColor: HrkColors.flutterSky,
        );
        check(s1.secondaryPalette.hue).notEquals(s2.secondaryPalette.hue);
      });
    });

    test('Light ColorScheme Colors', () {
      final colorScheme = CustomTheme.themeDataLight.colorScheme;
      expect(colorScheme.primary, const Color(0xff4d76c3));
      expect(colorScheme.primaryContainer, const Color(0xffbed1ff));
      expect(colorScheme.onPrimaryContainer, const Color(0xff0f448e));
      expect(colorScheme.primaryFixed, const Color(0xffd8e2ff));
      expect(colorScheme.primaryFixedDim, const Color(0xffadc6ff));
      expect(colorScheme.onPrimaryFixed, const Color(0xff001a41));
      expect(colorScheme.onPrimaryFixedVariant, const Color(0xff0f448e));
      expect(colorScheme.secondary, const Color(0xff4d76c3));
      expect(colorScheme.onSecondary, const Color(0xffffffff));
      expect(colorScheme.secondaryContainer, const Color(0xffbed1ff));
      expect(colorScheme.onSecondaryContainer, const Color(0xff0f448e));
      expect(colorScheme.secondaryFixed, const Color(0xffd8e2ff));
      expect(colorScheme.secondaryFixedDim, const Color(0xffadc6ff));
      expect(colorScheme.onSecondaryFixed, const Color(0xff001a41));
      expect(colorScheme.onSecondaryFixedVariant, const Color(0xff0f448e));
      expect(colorScheme.tertiary, const Color(0xff8b6d8d));
      expect(colorScheme.onTertiary, const Color(0xffffffff));
      expect(colorScheme.tertiaryContainer, const Color(0xffeac7ea));
      expect(colorScheme.onTertiaryContainer, const Color(0xff583e5b));
      expect(colorScheme.tertiaryFixed, const Color(0xfffbd7fc));
      expect(colorScheme.tertiaryFixedDim, const Color(0xffdebcdf));
      expect(colorScheme.onTertiaryFixed, const Color(0xff29132d));
      expect(colorScheme.onTertiaryFixedVariant, const Color(0xff583e5b));
      expect(colorScheme.error, const Color(0xffde3730));
      expect(colorScheme.errorContainer, const Color(0xffffc3bc));
      expect(colorScheme.onErrorContainer, const Color(0xff93000a));
      expect(colorScheme.surface, const Color(0xfff9f9ff));
      expect(colorScheme.onSurface, const Color(0xff1a1b20));
      expect(colorScheme.surfaceDim, const Color(0xffd9d9e0));
      expect(colorScheme.surfaceBright, const Color(0xfff9f9ff));
      expect(colorScheme.surfaceContainerLow, const Color(0xfff3f3fa));
      expect(colorScheme.surfaceContainer, const Color(0xffededf4));
      expect(colorScheme.surfaceContainerHigh, const Color(0xffe8e7ee));
      expect(colorScheme.surfaceContainerHighest, const Color(0xffe2e2e9));
      expect(colorScheme.onSurfaceVariant, const Color(0xff2e3038));
      expect(colorScheme.outline, const Color(0xff75777f));
      expect(colorScheme.outlineVariant, const Color(0xffc4c6d0));
      expect(colorScheme.inverseSurface, const Color(0xff2f3036));
      expect(colorScheme.onInverseSurface, const Color(0xfff0f0f7));
      expect(colorScheme.inversePrimary, const Color(0xffadc6ff));
      expect(colorScheme.surfaceTint, const Color(0xff315da8));
      // ignore: deprecated_member_use
      expect(colorScheme.background, const Color(0xfff9f9ff));
      // ignore: deprecated_member_use
      expect(colorScheme.onBackground, const Color(0xff1a1b20));
      // ignore: deprecated_member_use
      expect(colorScheme.surfaceVariant, const Color(0xffe1e2ec));
    });

    test('Dark ColorScheme Colors', () {
      final colorScheme = CustomTheme.themeDataDark.colorScheme;
      expect(colorScheme.primary, const Color(0xff83abfb));
      expect(colorScheme.onPrimary, const Color(0xff002e69));
      expect(colorScheme.primaryContainer, const Color(0xff0f448e));
      expect(colorScheme.onPrimaryContainer, const Color(0xffd8e2ff));
      expect(colorScheme.primaryFixed, const Color(0xffd8e2ff));
      expect(colorScheme.primaryFixedDim, const Color(0xffadc6ff));
      expect(colorScheme.onPrimaryFixed, const Color(0xff001a41));
      expect(colorScheme.onPrimaryFixedVariant, const Color(0xff0f448e));
      expect(colorScheme.secondary, const Color(0xff83abfb));
      expect(colorScheme.onSecondary, const Color(0xff002e69));
      expect(colorScheme.secondaryContainer, const Color(0xff0f448e));
      expect(colorScheme.onSecondaryContainer, const Color(0xffd8e2ff));
      expect(colorScheme.secondaryFixed, const Color(0xffd8e2ff));
      expect(colorScheme.secondaryFixedDim, const Color(0xffadc6ff));
      expect(colorScheme.onSecondaryFixed, const Color(0xff001a41));
      expect(colorScheme.onSecondaryFixedVariant, const Color(0xff0f448e));
      expect(colorScheme.tertiary, const Color(0xffc2a1c3));
      expect(colorScheme.onTertiary, const Color(0xff402843));
      expect(colorScheme.tertiaryContainer, const Color(0xff583e5b));
      expect(colorScheme.onTertiaryContainer, const Color(0xfffbd7fc));
      expect(colorScheme.tertiaryFixed, const Color(0xfffbd7fc));
      expect(colorScheme.tertiaryFixedDim, const Color(0xffdebcdf));
      expect(colorScheme.onTertiaryFixed, const Color(0xff29132d));
      expect(colorScheme.onTertiaryFixedVariant, const Color(0xff583e5b));
      expect(colorScheme.error, const Color(0xffff897d));
      expect(colorScheme.onError, const Color(0xff690005));
      expect(colorScheme.errorContainer, const Color(0xff93000a));
      expect(colorScheme.onErrorContainer, const Color(0xffffdad6));
      expect(colorScheme.surface, const Color(0xff26282d));
      expect(colorScheme.onSurface, const Color(0xffe2e2e9));
      expect(colorScheme.surfaceDim, const Color(0xff111318));
      expect(colorScheme.surfaceBright, const Color(0xff37393e));
      expect(colorScheme.surfaceContainerLowest, const Color(0xff222429));
      expect(colorScheme.surfaceContainerLow, const Color(0xff2f3036));
      expect(colorScheme.surfaceContainer, const Color(0xff33353a));
      expect(colorScheme.surfaceContainerHigh, const Color(0xff3e4045));
      expect(colorScheme.surfaceContainerHighest, const Color(0xff4e5056));
      expect(colorScheme.onSurfaceVariant, const Color(0xffe1e2ec));
      expect(colorScheme.outline, const Color(0xff8e9099));
      expect(colorScheme.outlineVariant, const Color(0xff44474f));
      expect(colorScheme.inverseSurface, const Color(0xffe2e2e9));
      expect(colorScheme.onInverseSurface, const Color(0xff2f3036));
      expect(colorScheme.inversePrimary, const Color(0xff315da8));
      expect(colorScheme.surfaceTint, const Color(0xffadc6ff));
      // ignore: deprecated_member_use
      expect(colorScheme.background, const Color(0xff26282d));
      // ignore: deprecated_member_use
      expect(colorScheme.onBackground, const Color(0xffe2e2e9));
      // ignore: deprecated_member_use
      expect(colorScheme.surfaceVariant, const Color(0xff44474f));
    });
  });
}
