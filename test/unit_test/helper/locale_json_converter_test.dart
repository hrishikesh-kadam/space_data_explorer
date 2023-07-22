import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:space_data_explorer/helper/helper.dart';

void main() {
  group('$LocaleJsonConverter Unit Test', () {
    const converter = LocaleJsonConverter();

    test('en', () {
      const locale = Locale('en');
      const JsonMap json = {
        'languageCode': 'en',
        'scriptCode': null,
        'countryCode': null,
      };
      final JsonMap? actualJson = converter.toJson(locale);
      expect(actualJson, json);
      final Locale? actualLocale = converter.fromJson(actualJson);
      expect(actualLocale, locale);
    });

    test('mr_IN', () {
      const locale = Locale('mr', 'IN');
      const JsonMap json = {
        'languageCode': 'mr',
        'scriptCode': null,
        'countryCode': 'IN',
      };
      final JsonMap? actualJson = converter.toJson(locale);
      expect(actualJson, json);
      final Locale? actualLocale = converter.fromJson(actualJson);
      expect(actualLocale, locale);
    });

    test('hi-Deva-IN', () {
      const locale = Locale.fromSubtags(
        languageCode: 'hi',
        scriptCode: 'Deva',
        countryCode: 'IN',
      );
      const JsonMap json = {
        'languageCode': 'hi',
        'scriptCode': 'Deva',
        'countryCode': 'IN',
      };
      final JsonMap? actualJson = converter.toJson(locale);
      expect(actualJson, json);
      final Locale? actualLocale = converter.fromJson(actualJson);
      expect(actualLocale, locale);
    });

    test('null', () {
      const Locale? locale = null;
      const JsonMap? localeJson = null;
      final JsonMap? actualJson = converter.toJson(locale);
      expect(actualJson, localeJson);
      final Locale? actualLocale = converter.fromJson(actualJson);
      expect(actualLocale, locale);
    });
  });
}
