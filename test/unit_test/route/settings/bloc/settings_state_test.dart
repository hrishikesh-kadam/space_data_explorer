import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:space_data_explorer/helper/helper.dart';
import 'package:space_data_explorer/language/language.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';

void main() {
  group('$SettingsState Unit Test', () {
    const localeListJsonConverter = LocaleListJsonConverter();

    test('Basic', () {
      const Language language = Language.english;
      const List<Locale>? systemLocales = null;
      final List<JsonMap>? systemLocalesJson =
          localeListJsonConverter.toJson(systemLocales);
      const String dateFormatPattern = SettingsBloc.dateSkeleton;
      const bool isAnyDialogShown = false;
      final SettingsState state = SettingsState(
        language: language,
        systemLocales: systemLocales,
        dateFormatPattern: dateFormatPattern,
        isAnyDialogShown: isAnyDialogShown,
      );
      final JsonMap json = {
        'language': language.code,
        'systemLocales': systemLocalesJson,
        'dateFormatPattern': dateFormatPattern,
        'isAnyDialogShown': isAnyDialogShown,
      };
      final JsonMap actualJson = state.toJson();
      expect(actualJson, json);
      final SettingsState actualState = SettingsState.fromJson(actualJson);
      expect(actualState, state);
    });

    test('systemLocales', () {
      const Language language = Language.english;
      const List<Locale> systemLocales = [
        Locale('en'),
      ];
      final List<JsonMap>? systemLocalesJson =
          localeListJsonConverter.toJson(systemLocales);
      const String dateFormatPattern = SettingsBloc.dateSkeleton;
      const bool isAnyDialogShown = false;
      final SettingsState state = SettingsState(
        language: language,
        systemLocales: systemLocales,
        dateFormatPattern: dateFormatPattern,
        isAnyDialogShown: isAnyDialogShown,
      );
      final JsonMap json = {
        'language': language.code,
        'systemLocales': systemLocalesJson,
        'dateFormatPattern': dateFormatPattern,
        'isAnyDialogShown': isAnyDialogShown,
      };
      final JsonMap actualJson = state.toJson();
      expect(actualJson, json);
      final SettingsState actualState = SettingsState.fromJson(actualJson);
      expect(actualState, state);
    });
  });
}
