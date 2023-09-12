import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../extension/common_finders.dart';

final localeTileFinder = find.byKey(SettingsScreen.localeTileKey);
final localeDialogFinder = find.byKey(SettingsScreen.localeDialogKey);

Future<void> tapLocaleTile(WidgetTester tester) async {
  await tester.tap(localeTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseLocale(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required Locale? locale,
}) async {
  await tester.tap(
    find.byKey(
      Key(
        SettingsScreen.getLocaleValueTitle(
          l10n: l10n,
          locale: locale,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> verifyLocaleTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required Locale? locale,
}) async {
  final subTitleFinder = find.descendantText(
    of: localeTileFinder,
    text: SettingsScreen.getLocaleValueTitle(
      l10n: l10n,
      locale: locale,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
