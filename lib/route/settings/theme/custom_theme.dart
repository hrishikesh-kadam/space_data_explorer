import 'package:flutter/material.dart';

import 'package:material_color_utilities/material_color_utilities.dart';

import '../name_theme_extension.dart';
import 'basic_theme.dart';

class CustomTheme {
  static const Color _seedColor = BasicTheme.seedColor;
  static const Color _secondaryColor = _seedColor;

  /// References:
  /// 1. https://github.com/flutter/flutter/blob/b0850beeb25f6d5b10426284f506557f66181b36/packages/flutter/lib/src/material/color_scheme.dart#L367
  /// 2. https://github.com/flutter/flutter/blob/b0850beeb25f6d5b10426284f506557f66181b36/packages/flutter/lib/src/material/color_scheme.dart#L1891
  /// 3. https://github.com/material-foundation/material-color-utilities/blob/140c6b199a1e3c8d7d24ecff4e88cf9e58e35d01/dart/lib/scheme/scheme_tonal_spot.dart#L23
  @visibleForTesting
  static DynamicScheme buildDynamicScheme({
    Color seedColor = CustomTheme._seedColor,
    bool isDark = false, // not in use, has no effect
    Color? secondaryColor,
  }) {
    // ignore: deprecated_member_use
    final Hct seedColorHct = Hct.fromInt(seedColor.value);
    final Hct? secondaryColorHct =
        // ignore: deprecated_member_use
        secondaryColor != null ? Hct.fromInt(secondaryColor.value) : null;
    return DynamicScheme(
      // ignore: deprecated_member_use
      sourceColorArgb: seedColor.value,
      variant: Variant.tonalSpot,
      isDark: isDark,
      primaryPalette: TonalPalette.of(seedColorHct.hue, 48.0),
      secondaryPalette: secondaryColor != null
          ? TonalPalette.of(secondaryColorHct!.hue, 48.0)
          : TonalPalette.of(seedColorHct.hue, 24.0),
      tertiaryPalette: TonalPalette.of(
        MathUtils.sanitizeDegreesDouble(seedColorHct.hue + 60.0),
        24.0,
      ),
      neutralPalette: TonalPalette.of(seedColorHct.hue, 6.0),
      neutralVariantPalette: TonalPalette.of(seedColorHct.hue, 8.0),
    );
  }

  static final DynamicScheme _dynamicScheme = buildDynamicScheme(
    secondaryColor: _secondaryColor,
  );

  /// References:
  /// 1. https://github.com/material-foundation/material-color-utilities/blob/140c6b199a1e3c8d7d24ecff4e88cf9e58e35d01/dart/lib/dynamiccolor/material_dynamic_colors.dart#L33
  /// 2. https://material-foundation.github.io/material-theme-builder/
  static final ThemeData themeDataLight = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      primary: Color(_dynamicScheme.primaryPalette.get(50)), // 40
      onPrimary: Color(_dynamicScheme.primaryPalette.get(100)),
      primaryContainer: Color(_dynamicScheme.primaryPalette.get(84)), // 90
      onPrimaryContainer: Color(_dynamicScheme.primaryPalette.get(30)),
      primaryFixed: Color(_dynamicScheme.primaryPalette.get(90)),
      primaryFixedDim: Color(_dynamicScheme.primaryPalette.get(80)),
      onPrimaryFixed: Color(_dynamicScheme.primaryPalette.get(10)),
      onPrimaryFixedVariant: Color(_dynamicScheme.primaryPalette.get(30)),
      secondary: Color(_dynamicScheme.secondaryPalette.get(50)), // 40
      onSecondary: Color(_dynamicScheme.secondaryPalette.get(100)),
      secondaryContainer: Color(_dynamicScheme.secondaryPalette.get(84)), // 90
      onSecondaryContainer: Color(_dynamicScheme.secondaryPalette.get(30)),
      secondaryFixed: Color(_dynamicScheme.secondaryPalette.get(90)),
      secondaryFixedDim: Color(_dynamicScheme.secondaryPalette.get(80)),
      onSecondaryFixed: Color(_dynamicScheme.secondaryPalette.get(10)),
      onSecondaryFixedVariant: Color(_dynamicScheme.secondaryPalette.get(30)),
      tertiary: Color(_dynamicScheme.tertiaryPalette.get(50)), // 40
      onTertiary: Color(_dynamicScheme.tertiaryPalette.get(100)),
      tertiaryContainer: Color(_dynamicScheme.tertiaryPalette.get(84)), // 90
      onTertiaryContainer: Color(_dynamicScheme.tertiaryPalette.get(30)),
      tertiaryFixed: Color(_dynamicScheme.tertiaryPalette.get(90)),
      tertiaryFixedDim: Color(_dynamicScheme.tertiaryPalette.get(80)),
      onTertiaryFixed: Color(_dynamicScheme.tertiaryPalette.get(10)),
      onTertiaryFixedVariant: Color(_dynamicScheme.tertiaryPalette.get(30)),
      error: Color(_dynamicScheme.errorPalette.get(50)), // 40
      onError: Color(_dynamicScheme.errorPalette.get(100)),
      errorContainer: Color(_dynamicScheme.errorPalette.get(84)), // 90
      onErrorContainer: Color(_dynamicScheme.errorPalette.get(30)),
      outline: Color(_dynamicScheme.neutralVariantPalette.get(50)),
      outlineVariant: Color(_dynamicScheme.neutralVariantPalette.get(80)),
      surface: Color(_dynamicScheme.neutralPalette.get(98)),
      onSurface: Color(_dynamicScheme.neutralPalette.get(10)),
      surfaceDim: Color(_dynamicScheme.neutralPalette.get(87)),
      surfaceBright: Color(_dynamicScheme.neutralPalette.get(98)),
      surfaceContainerLowest: Color(_dynamicScheme.neutralPalette.get(100)),
      surfaceContainerLow: Color(_dynamicScheme.neutralPalette.get(96)),
      surfaceContainer: Color(_dynamicScheme.neutralPalette.get(94)),
      surfaceContainerHigh: Color(_dynamicScheme.neutralPalette.get(92)),
      surfaceContainerHighest: Color(_dynamicScheme.neutralPalette.get(90)),
      onSurfaceVariant: Color(_dynamicScheme.neutralVariantPalette.get(20)),
      inverseSurface: Color(_dynamicScheme.neutralPalette.get(20)),
      onInverseSurface: Color(_dynamicScheme.neutralPalette.get(95)),
      inversePrimary: Color(_dynamicScheme.primaryPalette.get(80)),
      shadow: Color(_dynamicScheme.neutralPalette.get(0)),
      scrim: Color(_dynamicScheme.neutralPalette.get(0)),
      surfaceTint: Color(_dynamicScheme.primaryPalette.get(40)),
      // ignore: deprecated_member_use
      background: Color(_dynamicScheme.neutralPalette.get(98)),
      // ignore: deprecated_member_use
      onBackground: Color(_dynamicScheme.neutralPalette.get(10)),
      // ignore: deprecated_member_use
      surfaceVariant: Color(_dynamicScheme.neutralVariantPalette.get(90)),
    ),
    useMaterial3: true,
    extensions: const [
      NameThemeExtension(
        name: 'customThemeLight',
        displayName: 'Custom Theme Light',
      ),
    ],
  );

  static final ThemeData themeDataDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: Brightness.dark,
      primary: Color(_dynamicScheme.primaryPalette.get(70)), // 80
      onPrimary: Color(_dynamicScheme.primaryPalette.get(20)),
      primaryContainer: Color(_dynamicScheme.primaryPalette.get(30)),
      onPrimaryContainer: Color(_dynamicScheme.primaryPalette.get(90)),
      primaryFixed: Color(_dynamicScheme.primaryPalette.get(90)),
      primaryFixedDim: Color(_dynamicScheme.primaryPalette.get(80)),
      onPrimaryFixed: Color(_dynamicScheme.primaryPalette.get(10)),
      onPrimaryFixedVariant: Color(_dynamicScheme.primaryPalette.get(30)),
      secondary: Color(_dynamicScheme.secondaryPalette.get(70)), // 80
      onSecondary: Color(_dynamicScheme.secondaryPalette.get(20)),
      secondaryContainer: Color(_dynamicScheme.secondaryPalette.get(30)),
      onSecondaryContainer: Color(_dynamicScheme.secondaryPalette.get(90)),
      secondaryFixed: Color(_dynamicScheme.secondaryPalette.get(90)),
      secondaryFixedDim: Color(_dynamicScheme.secondaryPalette.get(80)),
      onSecondaryFixed: Color(_dynamicScheme.secondaryPalette.get(10)),
      onSecondaryFixedVariant: Color(_dynamicScheme.secondaryPalette.get(30)),
      tertiary: Color(_dynamicScheme.tertiaryPalette.get(70)), // 80
      onTertiary: Color(_dynamicScheme.tertiaryPalette.get(20)),
      tertiaryContainer: Color(_dynamicScheme.tertiaryPalette.get(30)),
      onTertiaryContainer: Color(_dynamicScheme.tertiaryPalette.get(90)),
      tertiaryFixed: Color(_dynamicScheme.tertiaryPalette.get(90)),
      tertiaryFixedDim: Color(_dynamicScheme.tertiaryPalette.get(80)),
      onTertiaryFixed: Color(_dynamicScheme.tertiaryPalette.get(10)),
      onTertiaryFixedVariant: Color(_dynamicScheme.tertiaryPalette.get(30)),
      error: Color(_dynamicScheme.errorPalette.get(70)), // 80
      onError: Color(_dynamicScheme.errorPalette.get(20)),
      errorContainer: Color(_dynamicScheme.errorPalette.get(30)),
      onErrorContainer: Color(_dynamicScheme.errorPalette.get(90)),
      outline: Color(_dynamicScheme.neutralVariantPalette.get(60)),
      outlineVariant: Color(_dynamicScheme.neutralVariantPalette.get(30)),
      surface: Color(_dynamicScheme.neutralPalette.get(16)), // 6
      onSurface: Color(_dynamicScheme.neutralPalette.get(90)),
      surfaceDim: Color(_dynamicScheme.neutralPalette.get(6)),
      surfaceBright: Color(_dynamicScheme.neutralPalette.get(24)),
      surfaceContainerLowest: Color(_dynamicScheme.neutralPalette.get(14)), // 4
      surfaceContainerLow: Color(_dynamicScheme.neutralPalette.get(20)), //10
      surfaceContainer: Color(_dynamicScheme.neutralPalette.get(22)), // 12
      surfaceContainerHigh: Color(_dynamicScheme.neutralPalette.get(27)), // 17
      surfaceContainerHighest:
          Color(_dynamicScheme.neutralPalette.get(34)), // 24
      onSurfaceVariant: Color(_dynamicScheme.neutralVariantPalette.get(90)),
      inverseSurface: Color(_dynamicScheme.neutralPalette.get(90)),
      onInverseSurface: Color(_dynamicScheme.neutralPalette.get(20)),
      inversePrimary: Color(_dynamicScheme.primaryPalette.get(40)),
      shadow: Color(_dynamicScheme.neutralPalette.get(0)),
      scrim: Color(_dynamicScheme.neutralPalette.get(0)),
      surfaceTint: Color(_dynamicScheme.primaryPalette.get(80)),
      // ignore: deprecated_member_use
      background: Color(_dynamicScheme.neutralPalette.get(16)), // 6
      // ignore: deprecated_member_use
      onBackground: Color(_dynamicScheme.neutralPalette.get(90)),
      // ignore: deprecated_member_use
      surfaceVariant: Color(_dynamicScheme.neutralVariantPalette.get(30)),
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    extensions: const [
      NameThemeExtension(
        name: 'customThemeDark',
        displayName: 'Custom Theme Dark',
      ),
    ],
  );
}
