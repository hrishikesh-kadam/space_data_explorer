import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_time_patterns.dart';

void main() {
  group('Time Format Unit Test', () {
    final Map<String, DateSymbols> dateTimeSymbols =
        Map<String, DateSymbols>.from(dateTimeSymbolMap());
    final Map<String, Map<String, String>> dateTimePatterns =
        dateTimePatternMap();

    group('English jm Time Format Patterns', () {
      test('Map Locale to Pattern', () {
        const Map<String, String> expected = {
          'en': 'h:mm a',
          'en_AU': 'h:mm a',
          'en_CA': 'h:mm a',
          'en_GB': 'HH:mm',
          'en_IE': 'HH:mm',
          'en_IN': 'h:mm a',
          'en_SG': 'h:mm a',
          'en_US': 'h:mm a',
          'en_ZA': 'HH:mm',
          'en_ISO': 'HH:mm',
          'en_MY': 'h:mm a',
          'en_NZ': 'h:mm a'
        };
        final Map<String, String> actual = {};
        for (final entry in dateTimePatterns.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final String dateFormatPattern = entry.value['jm']!;
            actual[locale] = dateFormatPattern;
          }
        }
        expect(actual, expected);
      });

      test('Map Patterns to Locales', () {
        const Map<String, Set<String>> expected = {
          'h:mm a': {
            'en',
            'en_AU',
            'en_CA',
            'en_IN',
            'en_SG',
            'en_US',
            'en_MY',
            'en_NZ'
          },
          'HH:mm': {'en_GB', 'en_IE', 'en_ZA', 'en_ISO'}
        };
        final Map<String, Set<String>> actual = {};
        for (final entry in dateTimePatterns.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final String dateFormatPattern = entry.value['jm']!;
            actual[dateFormatPattern] ??= <String>{};
            final Set<String> locales = actual[dateFormatPattern]!;
            locales.add(locale);
          }
        }
        expect(actual, expected);
      });
    });

    group('English Short Time Format Patterns', () {
      test('Map Locale to Pattern', () {
        const Map<String, String> expected = {
          'en_ISO': 'HH:mm',
          'en': 'h:mm a',
          'en_AU': 'h:mm a',
          'en_CA': 'h:mm a',
          'en_GB': 'HH:mm',
          'en_IE': 'HH:mm',
          'en_IN': 'h:mm a',
          'en_MY': 'h:mm a',
          'en_NZ': 'h:mm a',
          'en_SG': 'h:mm a',
          'en_US': 'h:mm a',
          'en_ZA': 'HH:mm'
        };
        final Map<String, String> actual = {};
        for (final entry in dateTimeSymbols.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final DateSymbols dateSymbols = entry.value;
            final String dateFormatPattern = dateSymbols.TIMEFORMATS.last;
            actual[locale] = dateFormatPattern;
          }
        }
        expect(actual, expected);
      });

      test('Map Patterns to Locales', () {
        const Map<String, Set<String>> expected = {
          'HH:mm': {'en_ISO', 'en_GB', 'en_IE', 'en_ZA'},
          'h:mm a': {
            'en',
            'en_AU',
            'en_CA',
            'en_IN',
            'en_MY',
            'en_NZ',
            'en_SG',
            'en_US'
          }
        };
        final Map<String, Set<String>> actual = {};
        for (final entry in dateTimeSymbols.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final DateSymbols dateSymbols = entry.value;
            final String dateFormatPattern = dateSymbols.TIMEFORMATS.last;
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
