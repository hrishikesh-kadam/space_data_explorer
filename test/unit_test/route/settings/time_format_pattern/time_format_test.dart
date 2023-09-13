import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:path/path.dart';

import 'package:space_data_explorer/route/settings/locale.dart';

void main() {
  group('Time Format Unit Test', () {
    final Map<String, DateSymbols> dateTimeSymbols =
        Map<String, DateSymbols>.from(dateTimeSymbolMap());
    final Map<String, Map<String, String>> dateTimePatterns =
        dateTimePatternMap();
    const relativePath = 'test/unit_test/route/settings/time_format_pattern';
    final testDirectory = Directory(join(Directory.current.path, relativePath));

    group('jm Time Format Patterns', () {
      final jmDirectory = Directory(join(testDirectory.path, 'jm'));
      jmDirectory.createSync();

      test('Map Pattern to Locales', () {
        final jsonMap = SplayTreeMap<String, List<String>>();
        for (final Locale locale in LocaleExt.getSupportedLocales()) {
          final Map<String, String> value =
              dateTimePatterns[locale.toString()]!;
          final String dateFormatPattern = value['jm']!;
          jsonMap[dateFormatPattern] ??= <String>[];
          final SplayTreeSet<String> localeStringSet =
              SplayTreeSet.from(jsonMap[dateFormatPattern]!);
          localeStringSet.add(locale.toString());
          jsonMap[dateFormatPattern] = localeStringSet.toList();
        }
        final jsonFile = File(join(
          jmDirectory.path,
          'pattern_to_locales.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });
    });

    group('Short Time Format Patterns', () {
      final shortDirectory = Directory(join(testDirectory.path, 'short'));
      shortDirectory.createSync();

      test('Map Pattern to Locales', () {
        final jsonMap = SplayTreeMap<String, List<String>>();
        for (final Locale locale in LocaleExt.getSupportedLocales()) {
          final DateSymbols dateSymbols = dateTimeSymbols[locale.toString()]!;
          final String dateFormatPattern = dateSymbols.TIMEFORMATS.last;
          jsonMap[dateFormatPattern] ??= <String>[];
          final SplayTreeSet<String> localeStringSet =
              SplayTreeSet.from(jsonMap[dateFormatPattern]!);
          localeStringSet.add(locale.toString());
          jsonMap[dateFormatPattern] = localeStringSet.toList();
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
