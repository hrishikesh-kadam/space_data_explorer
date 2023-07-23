import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/helper/helper.dart';

void main() {
  group('$LocaleListJsonConverter Unit Test', () {
    const converter = LocaleListJsonConverter();

    void testConverter(List<Locale> locales, List<dynamic> json) {
      final List<JsonMap>? convertedJson = converter.toJson(locales);
      expect(convertedJson, json);
      final List<Locale>? roundTripLocales = converter.fromJson(convertedJson);
      expect(roundTripLocales, locales);
      final List<Locale>? convertedLocales = converter.fromJson(json);
      expect(convertedLocales, locales);
      final List<JsonMap>? roundTripJson = converter.toJson(convertedLocales);
      expect(roundTripJson, json);
    }

    test('en', () {
      const List<Locale> locales = [Locale('en')];
      const List<JsonMap> json = [
        {'languageCode': 'en'}
      ];
      testConverter(locales, json);
    });

    test('en, mr_IN, hi-Deva-IN', () {
      const List<Locale> locales = [
        Locale('en'),
        Locale('mr', 'IN'),
        Locale.fromSubtags(
          languageCode: 'hi',
          scriptCode: 'Deva',
          countryCode: 'IN',
        )
      ];
      const List<JsonMap> json = [
        {'languageCode': 'en'},
        {'languageCode': 'mr', 'countryCode': 'IN'},
        {
          'languageCode': 'hi',
          'scriptCode': 'Deva',
          'countryCode': 'IN',
        }
      ];
      testConverter(locales, json);
    });

    test('dynamic', () {
      const List<Locale> locales = [Locale('en')];
      const List<dynamic> json = [
        {'languageCode': 'en'}
      ];
      testConverter(locales, json);
    });
  });
}
