import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/radio_dialog.dart';
import '../../../extension/common_finders.dart';

final textDirectionTileFinder = find.byKey(SettingsScreen.textDirectionTileKey);
final textDirectionDialogFinder = find.byKey(const Key(
  '${SettingsScreen.textDirectionTileKeyPrefix}'
  '${RadioDialog.keySuffixDefault}',
));
const textDirectionDialogKeyPrefix =
    '${SettingsScreen.textDirectionTileKeyPrefix}'
    '${RadioDialog.keyPrefixDefault}';
final textDirectionListViewFinder = find.byKey(const Key(
  '$textDirectionDialogKeyPrefix'
  '${RadioDialog.listViewKeySuffix}',
));

Finder getTextDirectionFinder({
  required AppLocalizations l10n,
  required TextDirection? textDirection,
}) {
  return find.byKey(Key(
    '$textDirectionDialogKeyPrefix'
    '${SettingsScreen.getTextDirectionValueTitle(
      l10n: l10n,
      textDirection: textDirection,
    )}',
  ));
}

Future<void> tapTextDirectionTile(WidgetTester tester) async {
  await tester.tap(textDirectionTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseTextDirection(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required TextDirection? textDirection,
}) async {
  final textDirectionFinder =
      getTextDirectionFinder(l10n: l10n, textDirection: textDirection);
  await tester.dragUntilVisible(
    textDirectionFinder,
    textDirectionListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(textDirectionFinder);
  await tester.pumpAndSettle();
}

Future<void> verifyTextDirectionTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required TextDirection? textDirection,
}) async {
  final subTitleFinder = find.descendantText(
    of: textDirectionTileFinder,
    text: SettingsScreen.getTextDirectionValueTitle(
      l10n: l10n,
      textDirection: textDirection,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
