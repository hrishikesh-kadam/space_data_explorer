import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/route/settings/time_format_pattern.dart';
import 'package:space_data_explorer/widgets/radio_dialog.dart';
import '../../../extension/common_finders.dart';
import '../settings_route.dart';

const TimeFormatPattern timeFormatPatternDefault =
    SettingsState.timeFormatPatternDefault;
final TimeFormatPattern timeFormatPatternNonDefault = SettingsScreen
    .timeFormatPatterns
    .toList()
    .reversed
    .firstWhere((element) => element != timeFormatPatternDefault);
final Finder timeFormatTileFinder =
    find.byKey(SettingsScreen.timeFormatTileKey);
final Finder timeFormatDialogFinder = find.byKey(const Key(
  '${SettingsScreen.timeFormatTileKeyPrefix}'
  '${RadioDialog.keySuffixDefault}',
));
const String timeFormatDialogKeyPrefix =
    '${SettingsScreen.timeFormatTileKeyPrefix}'
    '${RadioDialog.keyPrefixDefault}';
final Finder timeFormatListViewFinder = find.byKey(const Key(
  '$timeFormatDialogKeyPrefix'
  '${RadioDialog.listViewKeySuffix}',
));

Finder getTimeFormatPatternFinder({
  required AppLocalizations l10n,
  required TimeFormatPattern timeFormatPattern,
}) {
  return find.byKey(Key(
    '$timeFormatDialogKeyPrefix'
    '${SettingsScreen.getTimeFormatValueTitle(
      l10n: l10n,
      timeFormatPattern: timeFormatPattern,
    )}',
  ));
}

Future<void> tapTimeFormatTile(WidgetTester tester) async {
  await ensureTileVisible(tester, timeFormatTileFinder);
  await tester.tap(timeFormatTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseTimeFormat(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required TimeFormatPattern timeFormatPattern,
}) async {
  final timeFormatPatternFinder = getTimeFormatPatternFinder(
    l10n: l10n,
    timeFormatPattern: timeFormatPattern,
  );
  await tester.dragUntilVisible(
    timeFormatPatternFinder,
    timeFormatListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(timeFormatPatternFinder);
  await tester.pumpAndSettle();
}

Future<void> verifyTimeFormatTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required TimeFormatPattern timeFormatPattern,
}) async {
  final subTitleFinder = find.descendantText(
    of: timeFormatTileFinder,
    text: SettingsScreen.getTimeFormatValueTitle(
      l10n: l10n,
      timeFormatPattern: timeFormatPattern,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
