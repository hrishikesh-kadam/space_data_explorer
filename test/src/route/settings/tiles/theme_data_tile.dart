import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/radio_dialog.dart';
import '../../../extension/common_finders.dart';
import '../settings_route.dart';

const ThemeData? themeDataDefault = SettingsState.themeDataDefault;
final ThemeData? themeDataNonDefault = SettingsScreen.themeDatas
    .toList()
    .reversed
    .firstWhere((element) => element != themeDataDefault);
final Finder themeDataTileFinder = find.byKey(SettingsScreen.themeDataTileKey);
final Finder themeDataDialogFinder = find.byKey(const Key(
  '${SettingsScreen.themeDataTileKeyPrefix}'
  '${RadioDialog.keySuffixDefault}',
));
const String themeDataDialogKeyPrefix =
    '${SettingsScreen.themeDataTileKeyPrefix}'
    '${RadioDialog.keyPrefixDefault}';
final Finder themeDataListViewFinder = find.byKey(const Key(
  '$themeDataDialogKeyPrefix'
  '${RadioDialog.listViewKeySuffix}',
));

Finder getThemeDataFinder({
  required AppLocalizations l10n,
  required ThemeData? themeData,
}) {
  return find.byKey(Key(
    '$themeDataDialogKeyPrefix'
    '${SettingsScreen.getThemeDataValueTitle(l10n: l10n, themeData: themeData)}',
  ));
}

Future<void> tapThemeDataTile(WidgetTester tester) async {
  await ensureTileVisible(tester, themeDataTileFinder);
  await tester.tap(themeDataTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseThemeData(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required ThemeData? themeData,
}) async {
  final themeDataFinder = getThemeDataFinder(l10n: l10n, themeData: themeData);
  await tester.dragUntilVisible(
    themeDataFinder,
    themeDataListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(themeDataFinder);
  await tester.pumpAndSettle();
}

Future<void> verifyThemeDataTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required ThemeData? themeData,
}) async {
  final subTitleFinder = find.descendantText(
    of: themeDataTileFinder,
    text: SettingsScreen.getThemeDataValueTitle(
      l10n: l10n,
      themeData: themeData,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
