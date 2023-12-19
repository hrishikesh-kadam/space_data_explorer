import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/distance_unit_tile.dart';

void main() {
  group('$SettingsScreen ${l10n.distanceUnit} Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await ensureTileVisible(tester, distanceUnitTileFinder);
      expect(distanceUnitTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(
          settingsBloc.state.distanceUnit, SettingsState.distanceUnitDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final distanceUnit in SettingsScreen.distanceUnits) {
        await tapDistanceUnitTile(tester);
        expect(distanceUnitDialogFinder, findsOneWidget);
        await chooseDistanceUnit(tester,
            l10n: l10n, distanceUnit: distanceUnit);
        expect(distanceUnitDialogFinder, findsNothing);
        await verifyDistanceUnitTileSubtitle(tester,
            l10n: l10n, distanceUnit: distanceUnit);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.distanceUnit, distanceUnit);
      }
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      final distanceUnit = settingsBloc.state.distanceUnit;
      await tapDistanceUnitTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(distanceUnitDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.distanceUnit, distanceUnit);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapDistanceUnitTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(distanceUnitDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose $distanceUnitNonDefault, exit screen, enter again',
        (tester) async {
      final distanceUnit = distanceUnitNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDistanceUnitTile(tester);
      await chooseDistanceUnit(tester, l10n: l10n, distanceUnit: distanceUnit);
      await verifyDistanceUnitTileSubtitle(tester,
          l10n: l10n, distanceUnit: distanceUnit);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.distanceUnit, distanceUnit);
      await tapBackButton(tester);
      await tapSettingsAction(tester);
      await ensureTileVisible(tester, distanceUnitTileFinder);
      await verifyDistanceUnitTileSubtitle(tester,
          l10n: l10n, distanceUnit: distanceUnit);
      expect(settingsBloc.state.distanceUnit, distanceUnit);
    });

    testWidgets('Choose $distanceUnitNonDefault twice', (tester) async {
      final distanceUnit = distanceUnitNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDistanceUnitTile(tester);
      await chooseDistanceUnit(tester, l10n: l10n, distanceUnit: distanceUnit);
      await tapDistanceUnitTile(tester);
      await chooseDistanceUnit(tester, l10n: l10n, distanceUnit: distanceUnit);
      await verifyDistanceUnitTileSubtitle(tester,
          l10n: l10n, distanceUnit: distanceUnit);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.distanceUnit, distanceUnit);
    });
  });
}
