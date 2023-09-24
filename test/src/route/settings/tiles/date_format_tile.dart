import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/date_format_pattern.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../extension/common_finders.dart';
import '../../../globals.dart';

final dateFormatTileFinder = find.byKey(SettingsScreen.dateFormatTileKey);
final dateFormatDialogFinder = find.byKey(SettingsScreen.dateFormatDialogKey);
final dateFormatListViewFinder = find.byKey(Key('${l10n.dateFormat}_listview'));

Future<void> tapDateFormatTile(WidgetTester tester) async {
  await tester.tap(dateFormatTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseDateFormat(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DateFormatPattern dateFormatPattern,
}) async {
  final dateFormatPatternFinder = find.byKey(Key(
    SettingsScreen.getDateFormatValueTitle(
      l10n: l10n,
      dateFormatPattern: dateFormatPattern,
    ),
  ));
  await tester.dragUntilVisible(
    dateFormatPatternFinder,
    dateFormatListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(dateFormatPatternFinder);
  await tester.pumpAndSettle();
}

Future<void> verifyDateFormatTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DateFormatPattern dateFormatPattern,
}) async {
  final subTitleFinder = find.descendantText(
    of: dateFormatTileFinder,
    text: SettingsScreen.getDateFormatValueTitle(
      l10n: l10n,
      dateFormatPattern: dateFormatPattern,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
