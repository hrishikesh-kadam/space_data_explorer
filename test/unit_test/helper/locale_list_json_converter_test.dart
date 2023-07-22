import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:space_data_explorer/helper/helper.dart';

void main() {
  group('$LocaleListJsonConverter Unit Test', () {
    const converter = LocaleListJsonConverter();

    test('en', () {
      const List<Locale> locales = [Locale('en')];
      const List<JsonMap> json = [
        {
          'languageCode': 'en',
          'scriptCode': null,
          'countryCode': null,
        }
      ];
      final List<JsonMap>? actualJson = converter.toJson(locales);
      expect(actualJson, json);
      final List<Locale>? actualLocales = converter.fromJson(actualJson);
      expect(actualLocales, locales);
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
        {
          'languageCode': 'en',
          'scriptCode': null,
          'countryCode': null,
        },
        {
          'languageCode': 'mr',
          'scriptCode': null,
          'countryCode': 'IN',
        },
        {
          'languageCode': 'hi',
          'scriptCode': 'Deva',
          'countryCode': 'IN',
        }
      ];
      final List<JsonMap>? actualJson = converter.toJson(locales);
      expect(actualJson, json);
      final List<Locale>? actualLocales = converter.fromJson(actualJson);
      expect(actualLocales, locales);
    });

    test('List<dynamic>', () {
      const List<dynamic> json = [
        {
          'languageCode': 'en',
          'scriptCode': null,
          'countryCode': null,
        }
      ];
      converter.fromJson(json as List<Map<String, dynamic>>);
    });
  });
}
