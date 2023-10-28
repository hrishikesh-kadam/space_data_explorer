import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/radio_dialog.dart';
import '../../../extension/common_finders.dart';
import '../settings_route.dart';

const Locale? localeDefault = SettingsState.localeDefault;
final Locale? localeNonDefault = SettingsScreen.locales
    .toList()
    .reversed
    .firstWhere((element) => element != localeDefault);
final Finder localeTileFinder = find.byKey(SettingsScreen.localeTileKey);
final Finder localeDialogFinder = find.byKey(const Key(
  '${SettingsScreen.localeTileKeyPrefix}'
  '${RadioDialog.keySuffixDefault}',
));
const String localeDialogKeyPrefix = '${SettingsScreen.localeTileKeyPrefix}'
    '${RadioDialog.keyPrefixDefault}';
final Finder localeListViewFinder = find.byKey(const Key(
  '$localeDialogKeyPrefix'
  '${RadioDialog.listViewKeySuffix}',
));

Finder getLocaleFinder({
  required AppLocalizations l10n,
  required Locale? locale,
}) {
  return find.byKey(Key(
    '$localeDialogKeyPrefix'
    '${SettingsScreen.getLocaleValueTitle(l10n: l10n, locale: locale)}',
  ));
}

Future<void> tapLocaleTile(WidgetTester tester) async {
  await ensureTileVisible(tester, localeTileFinder);
  await tester.tap(localeTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseLocale(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required Locale? locale,
}) async {
  final localeFinder = getLocaleFinder(l10n: l10n, locale: locale);
  await tester.dragUntilVisible(
    localeFinder,
    localeListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(localeFinder);
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
