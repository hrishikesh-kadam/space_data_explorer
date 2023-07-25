import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/helper/helper.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/date_format_pattern.dart';
import 'package:space_data_explorer/route/settings/language.dart';

void main() {
  group('$SettingsState Unit Test', () {
    const Language language = Language.english;
    const DateFormatPattern dateFormatPattern = DateFormatPattern.yMd;
    final SettingsState initialState = SettingsState(
      language: language,
      dateFormatPattern: dateFormatPattern,
    );
    final JsonMap initialJson = {
      'language': language.code,
      'dateFormatPattern': dateFormatPattern.pattern,
    };
    late JsonMap json;
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

    setUp(() {
      json = JsonMap.of(initialJson);
    });

    test('Basic', () {
      final SettingsState state = initialState.copyWith();
      testConverter(state, json);
    });

    test('systemLocales', () {
      const List<Locale> systemLocales = [
        Locale('en'),
      ];
      final List<JsonMap>? systemLocalesJson =
          localeListJsonConverter.toJson(systemLocales);
      final SettingsState state = initialState.copyWith(
        systemLocales: systemLocales,
      );
      json['systemLocales'] = systemLocalesJson;
      testConverter(state, json);
    });

    test('isAnyDialogShown', () {
      const isAnyDialogShown = true;
      final SettingsState state = initialState.copyWith(
        isAnyDialogShown: isAnyDialogShown,
      );
      json['isAnyDialogShown'] = isAnyDialogShown;
      testConverter(state, json);
    });
  });
}
