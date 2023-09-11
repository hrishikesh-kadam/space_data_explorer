import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_time_patterns.dart';

void main() {
  group('Date Format Unit Test', () {
    final Map<String, DateSymbols> dateTimeSymbols =
        Map<String, DateSymbols>.from(dateTimeSymbolMap());
    final Map<String, Map<String, String>> dateTimePatterns =
        dateTimePatternMap();

    group('English yMd Date Format Patterns', () {
      test('Map Locale to Date Format Pattern', () {
        const Map<String, String> expected = {
          'en': 'M/d/y',
          'en_AU': 'dd/MM/y',
          'en_CA': 'M/d/y',
          'en_GB': 'dd/MM/y',
          'en_IE': 'd/M/y',
          'en_IN': 'd/M/y',
          'en_SG': 'dd/MM/y',
          'en_US': 'M/d/y',
          'en_ZA': 'y/MM/dd',
          'en_ISO': 'M/d/y',
          'en_MY': 'dd/MM/y',
          'en_NZ': 'd/MM/y'
        };
        final Map<String, String> actual = {};
        for (final entry in dateTimePatterns.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final String dateFormatPattern = entry.value['yMd']!;
            actual[locale] = dateFormatPattern;
          }
        }
        expect(actual, expected);
      });

      test('Map Date Format Patterns to Locales', () {
        const Map<String, Set<String>> expected = {
          'M/d/y': {'en', 'en_CA', 'en_US', 'en_ISO'},
          'dd/MM/y': {'en_AU', 'en_GB', 'en_SG', 'en_MY'},
          'd/M/y': {'en_IE', 'en_IN'},
          'y/MM/dd': {'en_ZA'},
          'd/MM/y': {'en_NZ'},
        };
        final Map<String, Set<String>> actual = {};
        for (final entry in dateTimePatterns.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final String dateFormatPattern = entry.value['yMd']!;
            actual[dateFormatPattern] ??= <String>{};
            final Set<String> locales = actual[dateFormatPattern]!;
            locales.add(locale);
          }
        }
        expect(actual, expected);
      });
    });

    group('English Short Date Format Patterns', () {
      test('Map Locale to Date Format Pattern', () {
        const Map<String, String> expected = {
          'en_ISO': 'yyyy-MM-dd',
          'en': 'M/d/yy',
          'en_AU': 'd/M/yy',
          'en_CA': 'M/d/yy',
          'en_GB': 'dd/MM/y',
          'en_IE': 'dd/MM/y',
          'en_IN': 'dd/MM/yy',
          'en_MY': 'dd/MM/y',
          'en_NZ': 'd/MM/yy',
          'en_SG': 'd/M/yy',
          'en_US': 'M/d/yy',
          'en_ZA': 'y/MM/dd',
        };
        final Map<String, String> actual = {};
        for (final entry in dateTimeSymbols.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final DateSymbols dateSymbols = entry.value;
            final String dateFormatPattern = dateSymbols.DATEFORMATS.last;
            actual[locale] = dateFormatPattern;
          }
        }
        expect(actual, expected);
      });

      test('Map Date Format Patterns to Locales', () {
        const Map<String, Set<String>> expected = {
          'yyyy-MM-dd': {'en_ISO'},
          'M/d/yy': {'en', 'en_CA', 'en_US'},
          'd/M/yy': {'en_AU', 'en_SG'},
          'dd/MM/y': {'en_GB', 'en_IE', 'en_MY'},
          'dd/MM/yy': {'en_IN'},
          'd/MM/yy': {'en_NZ'},
          'y/MM/dd': {'en_ZA'},
        };
        final Map<String, Set<String>> actual = {};
        for (final entry in dateTimeSymbols.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final DateSymbols dateSymbols = entry.value;
            final String dateFormatPattern = dateSymbols.DATEFORMATS.last;
            actual[dateFormatPattern] ??= <String>{};
            final Set<String> locales = actual[dateFormatPattern]!;
            locales.add(locale);
          }
        }
        expect(actual, expected);
      });
    });
  });
}
