import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/radio_dialog.dart';
import '../../../extension/common_finders.dart';
import '../settings_route.dart';

const DistanceUnit diameterUnitDefault = SettingsState.diameterUnitDefault;
final DistanceUnit diameterUnitNonDefault = SettingsScreen.diameterUnits
    .firstWhere((element) => element != diameterUnitDefault);
final Finder diameterUnitTileFinder =
    find.byKey(SettingsScreen.diameterUnitTileKey);
final Finder diameterUnitDialogFinder = find.byKey(const Key(
  '${SettingsScreen.diameterUnitTileKeyPrefix}'
  '${RadioDialog.keySuffixDefault}',
));
const String diameterUnitDialogKeyPrefix =
    '${SettingsScreen.diameterUnitTileKeyPrefix}'
    '${RadioDialog.keyPrefixDefault}';
final Finder diameterUnitListViewFinder = find.byKey(const Key(
  '$diameterUnitDialogKeyPrefix'
  '${RadioDialog.listViewKeySuffix}',
));

Finder getDiameterUnitFinder({
  required AppLocalizations l10n,
  required DistanceUnit diameterUnit,
}) {
  return find.byKey(Key(
    '$diameterUnitDialogKeyPrefix'
    '${SettingsScreen.getDiameterUnitValueTitle(
      l10n: l10n,
      diameterUnit: diameterUnit,
    )}',
  ));
}

Future<void> tapDiameterUnitTile(WidgetTester tester) async {
  await tester.dragUntilVisible(
    diameterUnitTileFinder,
    settingsListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(diameterUnitTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseDiameterUnit(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DistanceUnit diameterUnit,
}) async {
  final diameterUnitFinder = getDiameterUnitFinder(
    l10n: l10n,
    diameterUnit: diameterUnit,
  );
  await tester.dragUntilVisible(
    diameterUnitFinder,
    diameterUnitListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(diameterUnitFinder);
  await tester.pumpAndSettle();
}

Future<void> verifyDiameterUnitTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DistanceUnit diameterUnit,
}) async {
  final subTitleFinder = find.descendantText(
    of: diameterUnitTileFinder,
    text: SettingsScreen.getDiameterUnitValueTitle(
      l10n: l10n,
      diameterUnit: diameterUnit,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
