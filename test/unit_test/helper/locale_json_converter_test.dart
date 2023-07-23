import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/helper/helper.dart';

void main() {
  group('$LocaleJsonConverter Unit Test', () {
    const converter = LocaleJsonConverter();

    void testConverter(Locale? locale, JsonMap? json) {
      final JsonMap? convertedJson = converter.toJson(locale);
      expect(convertedJson, json);
      final Locale? roundTripLocale = converter.fromJson(convertedJson);
      expect(roundTripLocale, locale);
      final Locale? convertedLocale = converter.fromJson(json);
      expect(convertedLocale, locale);
      final JsonMap? roundTripJson = converter.toJson(convertedLocale);
      expect(roundTripJson, json);
    }

    test('en', () {
      const locale = Locale('en');
      const JsonMap json = {'languageCode': 'en'};
      testConverter(locale, json);
    });

    test('mr_IN', () {
      const locale = Locale('mr', 'IN');
      const JsonMap json = {'languageCode': 'mr', 'countryCode': 'IN'};
      testConverter(locale, json);
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
      testConverter(locale, json);
    });

    test('null', () {
      const Locale? locale = null;
      const JsonMap? json = null;
      testConverter(locale, json);
    });

    test('dynamic', () {
      const locale = Locale.fromSubtags(
        languageCode: 'hi',
        scriptCode: 'Deva',
        countryCode: 'IN',
      );
      const dynamic json = {
        'languageCode': 'hi',
        'scriptCode': 'Deva',
        'countryCode': 'IN',
      };
      testConverter(locale, json);
    });
  });
}
