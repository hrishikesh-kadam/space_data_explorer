import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';

void main() {
  group('Date Format Unit Test', skip: true, () {
    final Map<String, DateSymbols> dateTimeSymbols =
        Map<String, DateSymbols>.from(dateTimeSymbolMap());

    group('English Date Format Patterns', () {
      test('Map Locale to Date Format Pattern', () {
        const Map<String, String> expected = {
          'en_ISO': 'yyyy-MM-dd',
          'en': 'M/d/yy',
          'en_AU': 'd/M/yy',
          'en_CA': 'y-MM-dd',
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
          'M/d/yy': {'en', 'en_US'},
          'd/M/yy': {'en_AU', 'en_SG'},
          'y-MM-dd': {'en_CA'},
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
