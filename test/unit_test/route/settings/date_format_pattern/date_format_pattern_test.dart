import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:path/path.dart';

import 'package:space_data_explorer/route/settings/locale.dart';

void main() {
  group('Date Format Unit Test', () {
    final Map<String, DateSymbols> dateTimeSymbols =
        Map<String, DateSymbols>.from(dateTimeSymbolMap());
    final Map<String, Map<String, String>> dateTimePatterns =
        dateTimePatternMap();
    const relativePath = 'test/unit_test/route/settings/date_format_pattern';
    final testDirectory = Directory(join(Directory.current.path, relativePath));

    test('Use all en variants', () {
      final List<String> localeList = availableLocalesForDateFormatting;
      final Set<String> enAvailableLocaleSet = {};
      final Set<String> enSupportedLocaleSet = {};
      for (String locale in localeList) {
        if (locale.startsWith('en')) {
          if (locale == 'en_ISO') {
            continue;
          }
          enAvailableLocaleSet.add(locale);
        }
      }
      for (Locale locale in LocaleExt.getSupportedLocales()) {
        final localeString = locale.toString();
        if (localeString.startsWith('en')) {
          if (localeString == 'en_ISO') {
            continue;
          }
          enSupportedLocaleSet.add(localeString);
        }
      }
      expect(enAvailableLocaleSet, enSupportedLocaleSet);
    });

    group('yMd Date Format Patterns', () {
      final yMdDirectory = Directory(join(testDirectory.path, 'yMd'));
      yMdDirectory.createSync();

      test('Map Pattern to Locales', () {
        final jsonMap = SplayTreeMap<String, List<String>>();
        for (final Locale locale in LocaleExt.getSupportedLocales()) {
          final Map<String, String> value =
              dateTimePatterns[locale.toString()]!;
          final String dateFormatPattern = value['yMd']!;
          jsonMap[dateFormatPattern] ??= <String>[];
          final SplayTreeSet<String> localeStringSet =
              SplayTreeSet.from(jsonMap[dateFormatPattern]!);
          localeStringSet.add(locale.toString());
          jsonMap[dateFormatPattern] = localeStringSet.toList();
        }
        final jsonFile = File(join(
          yMdDirectory.path,
          'pattern_to_locales.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });
    });

    group('Short Date Format Patterns', () {
      final shortDirectory = Directory(join(testDirectory.path, 'short'));
      shortDirectory.createSync();

      test('Map Pattern to Locales', () {
        final jsonMap = SplayTreeMap<String, List<String>>();
        for (final Locale locale in LocaleExt.getSupportedLocales()) {
          final DateSymbols dateSymbols = dateTimeSymbols[locale.toString()]!;
          final String dateFormatPattern = dateSymbols.DATEFORMATS.last;
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
