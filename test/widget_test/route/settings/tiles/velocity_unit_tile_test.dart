import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/velocity_unit_tile.dart';

void main() {
  group('$SettingsScreen ${l10n.velocityUnit} Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await ensureTileVisible(tester, velocityUnitTileFinder);
      expect(velocityUnitTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(
          settingsBloc.state.velocityUnit, SettingsState.velocityUnitDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final velocityUnit in SettingsScreen.velocityUnits) {
        await tapVelocityUnitTile(tester);
        expect(velocityUnitDialogFinder, findsOneWidget);
        await chooseVelocityUnit(tester,
            l10n: l10n, velocityUnit: velocityUnit);
        expect(velocityUnitDialogFinder, findsNothing);
        await verifyVelocityUnitTileSubtitle(tester,
            l10n: l10n, velocityUnit: velocityUnit);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.velocityUnit, velocityUnit);
      }
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      final velocityUnit = settingsBloc.state.velocityUnit;
      await tapVelocityUnitTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(velocityUnitDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.velocityUnit, velocityUnit);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapVelocityUnitTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(velocityUnitDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose $velocityUnitNonDefault, exit screen, enter again',
        (tester) async {
      final velocityUnit = velocityUnitNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapVelocityUnitTile(tester);
      await chooseVelocityUnit(tester, l10n: l10n, velocityUnit: velocityUnit);
      await verifyVelocityUnitTileSubtitle(tester,
          l10n: l10n, velocityUnit: velocityUnit);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.velocityUnit, velocityUnit);
      await tapBackButton(tester);
      await tapSettingsAction(tester);
      await ensureTileVisible(tester, velocityUnitTileFinder);
      await verifyVelocityUnitTileSubtitle(tester,
          l10n: l10n, velocityUnit: velocityUnit);
      expect(settingsBloc.state.velocityUnit, velocityUnit);
    });
  });
}
