import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:path/path.dart';

void main() {
  group('Date Format Unit Test', () {
    final Map<String, DateSymbols> dateTimeSymbols =
        Map<String, DateSymbols>.from(dateTimeSymbolMap());
    final Map<String, Map<String, String>> dateTimePatterns =
        dateTimePatternMap();
    const relativePath = 'test/unit_test/route/settings/date_format_pattern';
    final testDirectory = Directory(join(Directory.current.path, relativePath));

    group('English yMd Date Format Patterns', () {
      final yMdDirectory = Directory(join(testDirectory.path, 'yMd'));
      yMdDirectory.createSync();

      test('Map Locale to Pattern', () {
        final Map<String, String> jsonMap = {};
        for (final entry in dateTimePatterns.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final String dateFormatPattern = entry.value['yMd']!;
            jsonMap[locale] = dateFormatPattern;
          }
        }
        final jsonFile = File(join(
          yMdDirectory.path,
          'locale_to_pattern.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });

      test('Map Pattern to Locales', () {
        final Map<String, List<String>> jsonMap = {};
        for (final entry in dateTimePatterns.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final String dateFormatPattern = entry.value['yMd']!;
            jsonMap[dateFormatPattern] ??= <String>[];
            final Set<String> locales = jsonMap[dateFormatPattern]!.toSet();
            locales.add(locale);
            jsonMap[dateFormatPattern] = locales.toList();
          }
        }
        final jsonFile = File(join(
          yMdDirectory.path,
          'pattern_to_locales.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });
    });

    group('English Short Date Format Patterns', () {
      final shortDirectory = Directory(join(testDirectory.path, 'short'));
      shortDirectory.createSync();

      test('Map Locale to Pattern', () {
        final Map<String, String> jsonMap = {};
        for (final entry in dateTimeSymbols.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final DateSymbols dateSymbols = entry.value;
            final String dateFormatPattern = dateSymbols.DATEFORMATS.last;
            jsonMap[locale] = dateFormatPattern;
          }
        }
        final jsonFile = File(join(
          shortDirectory.path,
          'locale_to_pattern.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });

      test('Map Pattern to Locales', () {
        final Map<String, List<String>> jsonMap = {};
        for (final entry in dateTimeSymbols.entries) {
          if (entry.key.startsWith('en')) {
            final String locale = entry.key;
            final DateSymbols dateSymbols = entry.value;
            final String dateFormatPattern = dateSymbols.DATEFORMATS.last;
            jsonMap[dateFormatPattern] ??= <String>[];
            final Set<String> locales = jsonMap[dateFormatPattern]!.toSet();
            locales.add(locale);
            jsonMap[dateFormatPattern] = locales.toList();
          }
        }
        final jsonFile = File(join(
          shortDirectory.path,
          'pattern_to_locales.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });
    });
  });
}
