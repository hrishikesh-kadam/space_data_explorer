import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/route/settings/time_format_pattern.dart';
import '../../../extension/common_finders.dart';
import '../../../globals.dart';

final timeFormatTileFinder = find.byKey(SettingsScreen.timeFormatTileKey);
final timeFormatDialogFinder = find.byKey(SettingsScreen.timeFormatDialogKey);
final timeFormatListViewFinder = find.byKey(Key('${l10n.timeFormat}_listview'));

Future<void> tapTimeFormatTile(WidgetTester tester) async {
  await tester.tap(timeFormatTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseTimeFormat(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required TimeFormatPattern timeFormatPattern,
}) async {
  final timeFormatPatternFinder = find.byKey(Key(
    SettingsScreen.getTimeFormatValueTitle(
      l10n: l10n,
      timeFormatPattern: timeFormatPattern,
    ),
  ));
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
