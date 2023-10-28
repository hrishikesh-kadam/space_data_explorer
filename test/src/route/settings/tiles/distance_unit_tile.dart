import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/widgets/radio_dialog.dart';
import '../../../extension/common_finders.dart';
import '../settings_route.dart';

const DistanceUnit distanceUnitDefault = SettingsState.distanceUnitDefault;
final DistanceUnit distanceUnitNonDefault = SettingsScreen.distanceUnits
    .firstWhere((element) => element != distanceUnitDefault);
final Finder distanceUnitTileFinder =
    find.byKey(SettingsScreen.distanceUnitTileKey);
final Finder distanceUnitDialogFinder = find.byKey(const Key(
  '${SettingsScreen.distanceUnitTileKeyPrefix}'
  '${RadioDialog.keySuffixDefault}',
));
const String distanceUnitDialogKeyPrefix =
    '${SettingsScreen.distanceUnitTileKeyPrefix}'
    '${RadioDialog.keyPrefixDefault}';
final Finder distanceUnitListViewFinder = find.byKey(const Key(
  '$distanceUnitDialogKeyPrefix'
  '${RadioDialog.listViewKeySuffix}',
));

Finder getDistanceUnitFinder({
  required AppLocalizations l10n,
  required DistanceUnit distanceUnit,
}) {
  return find.byKey(Key(
    '$distanceUnitDialogKeyPrefix'
    '${SettingsScreen.getDistanceUnitValueTitle(
      l10n: l10n,
      distanceUnit: distanceUnit,
    )}',
  ));
}

Future<void> tapDistanceUnitTile(WidgetTester tester) async {
  await ensureTileVisible(tester, distanceUnitTileFinder);
  await tester.tap(distanceUnitTileFinder);
  await tester.pumpAndSettle();
}

Future<void> chooseDistanceUnit(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DistanceUnit distanceUnit,
}) async {
  final distanceUnitFinder = getDistanceUnitFinder(
    l10n: l10n,
    distanceUnit: distanceUnit,
  );
  await tester.dragUntilVisible(
    distanceUnitFinder,
    distanceUnitListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
  await tester.tap(distanceUnitFinder);
  await tester.pumpAndSettle();
}

Future<void> verifyDistanceUnitTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DistanceUnit distanceUnit,
}) async {
  final subTitleFinder = find.descendantText(
    of: distanceUnitTileFinder,
    text: SettingsScreen.getDistanceUnitValueTitle(
      l10n: l10n,
      distanceUnit: distanceUnit,
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
