import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/radio_dialog.dart';
import '../../../extension/common_finders.dart';
import '../settings_route.dart';

const VelocityUnit velocityUnitDefault = SettingsState.velocityUnitDefault;
final VelocityUnit velocityUnitNonDefault = SettingsScreen.velocityUnits
    .firstWhere((element) => element != velocityUnitDefault);
final Finder velocityUnitTileFinder =
    find.byKey(SettingsScreen.velocityUnitTileKey);
final Finder velocityUnitDialogFinder = find.byKey(const Key(
  '${SettingsScreen.velocityUnitTileKeyPrefix}'
  '${RadioDialog.keySuffixDefault}',
));
const String velocityUnitDialogKeyPrefix =
    '${SettingsScreen.velocityUnitTileKeyPrefix}'
    '${RadioDialog.keyPrefixDefault}';
final Finder velocityUnitListViewFinder = find.byKey(const Key(
  '$velocityUnitDialogKeyPrefix'
  '${RadioDialog.listViewKeySuffix}',
));

Finder getVelocityUnitFinder({
  required AppLocalizations l10n,
  required VelocityUnit velocityUnit,
}) {
  return find.byKey(Key(
    '$velocityUnitDialogKeyPrefix'
    '${SettingsScreen.getVelocityUnitValueTitle(
      l10n: l10n,
      velocityUnit: velocityUnit,
    )}',
  ));
}

Future<void> tapVelocityUnitTile(WidgetTester tester) async {
  await tester.dragUntilVisible(
    velocityUnitTileFinder,
    settingsListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(velocityUnitTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseVelocityUnit(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required VelocityUnit velocityUnit,
}) async {
  final velocityUnitFinder = getVelocityUnitFinder(
    l10n: l10n,
    velocityUnit: velocityUnit,
  );
  await tester.dragUntilVisible(
    velocityUnitFinder,
    velocityUnitListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(velocityUnitFinder);
  await tester.pumpAndSettle();
}

Future<void> verifyVelocityUnitTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required VelocityUnit velocityUnit,
}) async {
  final subTitleFinder = find.descendantText(
    of: velocityUnitTileFinder,
    text: SettingsScreen.getVelocityUnitValueTitle(
      l10n: l10n,
      velocityUnit: velocityUnit,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
