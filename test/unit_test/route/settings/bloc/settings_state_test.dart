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

    void testConverter(SettingsState state, JsonMap json) {
      final JsonMap convertedJson = state.toJson();
      expect(convertedJson, json);
      final SettingsState roundTripState =
          SettingsState.fromJson(convertedJson);
      expect(roundTripState, state);
      final SettingsState convertedState = SettingsState.fromJson(json);
      expect(convertedState, state);
      final JsonMap roundTripJson = convertedState.toJson();
      expect(roundTripJson, json);
    }

    test('Basic', () {
      const Language language = Language.english;
      const String dateFormatPattern = SettingsBloc.dateSkeleton;
      final SettingsState state = SettingsState(
        language: language,
        dateFormatPattern: dateFormatPattern,
      );
      final JsonMap json = {
        'language': language.code,
        'dateFormatPattern': dateFormatPattern,
      };
      testConverter(state, json);
    });

    test('systemLocales', () {
      const Language language = Language.english;
      const List<Locale> systemLocales = [
        Locale('en'),
      ];
      final List<JsonMap>? systemLocalesJson =
          localeListJsonConverter.toJson(systemLocales);
      const String dateFormatPattern = SettingsBloc.dateSkeleton;
      final SettingsState state = SettingsState(
        language: language,
        systemLocales: systemLocales,
        dateFormatPattern: dateFormatPattern,
      );
      final JsonMap json = {
        'language': language.code,
        'systemLocales': systemLocalesJson,
        'dateFormatPattern': dateFormatPattern,
      };
      testConverter(state, json);
    });

    test('isAnyDialogShown', () {
      const Language language = Language.english;
      const String dateFormatPattern = SettingsBloc.dateSkeleton;
      const isAnyDialogShown = true;
      final SettingsState state = SettingsState(
        language: language,
        dateFormatPattern: dateFormatPattern,
        isAnyDialogShown: isAnyDialogShown,
      );
      final JsonMap json = {
        'language': language.code,
        'dateFormatPattern': dateFormatPattern,
        'isAnyDialogShown': isAnyDialogShown,
      };
      testConverter(state, json);
    });
  });
}
