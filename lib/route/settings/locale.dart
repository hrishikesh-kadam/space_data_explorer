import 'package:flutter/material.dart';

extension LocaleExt on Locale {
  static const Locale en = Locale('en');
  static const Locale hi = Locale('hi');
  static const Locale mr = Locale('mr');
  // Below locales are included for formatting differences like date
  // See test/unit_test/route/settings/date_format_pattern/date_format_pattern_test.dart
  static const Locale enAu = Locale('en', 'AU');
  static const Locale enCa = Locale('en', 'CA');
  static const Locale enGb = Locale('en', 'GB');
  static const Locale enIe = Locale('en', 'IE');
  static const Locale enIn = Locale('en', 'IN');
  static const Locale enMy = Locale('en', 'MY');
  static const Locale enNz = Locale('en', 'NZ');
  static const Locale enSg = Locale('en', 'SG');
  static const Locale enUs = Locale('en', 'US');
  static const Locale enZa = Locale('en', 'ZA');

  static Set<Locale> getSupportedLocales() {
    return {
      en,
      hi,
      mr,
      enAu,
      enCa,
      enGb,
      enIe,
      enIn,
      enMy,
      enNz,
      enSg,
      enUs,
      enZa,
    };
  }

  String toDisplayName() {
    return switch (this) {
      en => 'English',
      hi => 'हिंदी / Hindi',
      mr => 'मराठी / Marathi',
      enAu => 'English (Australia)',
      enCa => 'English (Canada)',
      enGb => 'English (Great Britain)',
      enIe => 'English (Ireland)',
      enIn => 'English (India)',
      enMy => 'English (Malaysia)',
      enNz => 'English (New Zealand)',
      enSg => 'English (Singapore)',
      enUs => 'English (United States)',
      enZa => 'English (South Africa)',
      _ => toLanguageTag(),
    };
  }
}
