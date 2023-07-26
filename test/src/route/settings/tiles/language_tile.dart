import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/language.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';

final languageTileFinder = find.byKey(SettingsScreen.languageTileKey);
final languageDialogFinder = find.byKey(SettingsScreen.languageDialogKey);

Future<void> tapLanguageTile(WidgetTester tester) async {
  await tester.tap(languageTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseLanguage(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required Language language,
}) async {
  await tester.tap(
    find.byKey(
      Key(
        SettingsScreen.getLanguageValueTitle(
          l10n: l10n,
          language: language,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> verifyLanguageTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required Language language,
}) async {
  final subTitleFinder = find.descendant(
    of: languageTileFinder,
    matching: find.text(
      SettingsScreen.getLanguageValueTitle(
        l10n: l10n,
        language: language,
      ),
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
