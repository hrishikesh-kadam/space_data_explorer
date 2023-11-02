// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../constants/colors.dart';
import 'name_theme_extension.dart';

extension ThemeDataExt on ThemeData {
  static Set<ThemeData?> themeDatas = {
    system,
    light,
    dark,
    space,
    flexThemeDataLight,
    flexThemeDataDark,
    themeDataLight,
    themeDataDark,
  };

  String? get name {
    return extension<NameThemeExtension>()?.name;
  }

  String? get displayName {
    return extension<NameThemeExtension>()?.displayName;
  }

  static String getDisplayName({
    required AppLocalizations l10n,
    required ThemeData? themeData,
  }) {
    if (themeData == system) {
      return l10n.system;
    } else if (themeData == light) {
      return l10n.light;
    } else if (themeData == dark) {
      return l10n.dark;
    } else if (themeData == space) {
      return l10n.space;
    } else if (themeData!.displayName != null) {
      return themeData.displayName!;
    }
    throw ArgumentError.value(themeData, 'themeData', 'Invalid argument');
  }

  static const ThemeData? system = null;

  static final ThemeData light = flexThemeDataLight.copyWith(
    extensions: [
      const NameThemeExtension(name: 'light'),
    ],
  );

  static final ThemeData dark = flexThemeDataDark.copyWith(
    extensions: [
      const NameThemeExtension(name: 'dark'),
    ],
  );

  static final ThemeData flexThemeDataLight = FlexThemeData.light(
    colors: FlexSchemeColor.from(
      primary: ColorsExt.flutterBlue,
      secondary: ColorsExt.flutterSky,
    ),
    useMaterial3: true,
    keyColors: const FlexKeyColors(
      useSecondary: true,
    ),
    tones: const FlexTones.light().copyWith(
      primaryTone: 50,
      secondaryContainerTone: 84,
      backgroundTone: 98,
      surfaceTone: 98,
      // TODO(hrishikesh-kadam): Change this to some surfaceContainer
      // once they are available.
      surfaceVariantTone: 95,
    ),
    // subThemesData: const FlexSubThemesData(
    //   // appBarBackgroundSchemeColor: SchemeColor.inversePrimary,
    // ),
    extensions: [
      const NameThemeExtension(
        name: 'flexThemeDataLight',
        displayName: 'FlexThemeData Light',
      ),
    ],
  );

  static final ThemeData flexThemeDataDark = FlexThemeData.dark(
    colors: FlexSchemeColor.from(
      primary: ColorsExt.flutterBlue,
      secondary: ColorsExt.flutterSky,
    ),
    useMaterial3: true,
    keyColors: const FlexKeyColors(
      useSecondary: true,
    ),
    tones: const FlexTones.dark().copyWith(
      primaryTone: 70,
      backgroundTone: 15,
      surfaceTone: 15,
      // TODO(hrishikesh-kadam): Change this to some surfaceContainer
      // once they are available.
      surfaceVariantTone: 22,
    ),
    // subThemesData: const FlexSubThemesData(
    //   // appBarBackgroundSchemeColor: SchemeColor.inversePrimary,
    // ),
    extensions: [
      const NameThemeExtension(
        name: 'flexThemeDataDark',
        displayName: 'FlexThemeData Dark',
      ),
    ],
  );

  // WIP
  static final ThemeData space = flexThemeDataDark.copyWith(
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
    ),
    extensions: [
      const NameThemeExtension(name: 'space'),
    ],
  );

  static final ThemeData themeDataLight = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsExt.flutterBlue,
    ),
    useMaterial3: true,
    extensions: const [
      NameThemeExtension(
        name: 'themeDataLight',
        displayName: 'ThemeData Light',
      ),
    ],
  );

  static final ThemeData themeDataDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsExt.flutterBlue,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    extensions: const [
      NameThemeExtension(
        name: 'themeDataDark',
        displayName: 'ThemeData Dark',
      ),
    ],
  );
}

class ThemeDataJsonConverter implements JsonConverter<ThemeData?, String?> {
  const ThemeDataJsonConverter();

  @override
  ThemeData? fromJson(String? name) {
    if (name == null) {
      return null;
    }
    for (final ThemeData themeData in ThemeDataExt.themeDatas.nonNulls) {
      if (name == themeData.name) {
        return themeData;
      }
    }
    throw ArgumentError.value(name, 'name', 'Not serialized');
  }

  @override
  String? toJson(ThemeData? themeData) {
    if (themeData == null) {
      return null;
    }
    if (themeData.name != null) {
      return themeData.name;
    }
    throw ArgumentError.value(themeData, 'themeData', 'Not serialized');
  }
}
