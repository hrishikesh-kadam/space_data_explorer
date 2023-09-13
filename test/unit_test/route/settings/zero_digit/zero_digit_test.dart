import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart' as intl_number;
import 'package:path/path.dart';

import 'package:space_data_explorer/route/settings/locale.dart';

void main() {
  group('Zero digit Unit Test', () {
    final Map<String, DateSymbols> dateTimeSymbols =
        Map<String, DateSymbols>.from(dateTimeSymbolMap());
    final Map<String, NumberSymbols> numberFormatSymbols =
        Map<String, NumberSymbols>.from(intl_number.numberFormatSymbols);
    const relativePath = 'test/unit_test/route/settings/zero_digit';
    final testDirectory = Directory(join(Directory.current.path, relativePath));

    group('dateTimeSymbolMap', () {
      final directory = Directory(join(
        testDirectory.path,
        'dateTimeSymbolMap',
      ));
      directory.createSync();

      test('Map Pattern to Locales', () {
        final jsonMap = SplayTreeMap<String, List<String>>();
        for (final Locale locale in LocaleExt.getSupportedLocales()) {
          final DateSymbols dateSymbols = dateTimeSymbols[locale.toString()]!;
          final String zeroDigit = dateSymbols.ZERODIGIT.toString();
          jsonMap[zeroDigit] ??= <String>[];
          final SplayTreeSet<String> localeStringSet =
              SplayTreeSet.from(jsonMap[zeroDigit]!);
          localeStringSet.add(locale.toString());
          jsonMap[zeroDigit] = localeStringSet.toList();
        }
        final jsonFile = File(join(
          directory.path,
          'pattern_to_locales.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });
    });

    group('numberFormatSymbols', () {
      final directory = Directory(join(
        testDirectory.path,
        'numberFormatSymbols',
      ));
      directory.createSync();

      test('Map Pattern to Locales', () {
        final jsonMap = SplayTreeMap<String, List<String>>();
        for (final Locale locale in LocaleExt.getSupportedLocales()) {
          final NumberSymbols numberSymbols =
              numberFormatSymbols[locale.toString()]!;
          final String zeroDigit = numberSymbols.ZERO_DIGIT;
          jsonMap[zeroDigit] ??= <String>[];
          final SplayTreeSet<String> localeStringSet =
              SplayTreeSet.from(jsonMap[zeroDigit]!);
          localeStringSet.add(locale.toString());
          jsonMap[zeroDigit] = localeStringSet.toList();
        }
        final jsonFile = File(join(
          directory.path,
          'pattern_to_locales.json',
        ));
        jsonFile.writeAsStringSync(jsonEncoderPretty.convert(jsonMap));
      });
    });
  });
}
