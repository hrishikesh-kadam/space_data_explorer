import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/diameter_unit_tile.dart';

void main() {
  group('$SettingsScreen ${l10n.diameterUnit} Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      expect(diameterUnitTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(
          settingsBloc.state.diameterUnit, SettingsState.diameterUnitDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final diameterUnit in SettingsScreen.diameterUnits) {
        await tapDiameterUnitTile(tester);
        expect(diameterUnitDialogFinder, findsOneWidget);
        await chooseDiameterUnit(tester,
            l10n: l10n, diameterUnit: diameterUnit);
        expect(diameterUnitDialogFinder, findsNothing);
        await verifyDiameterUnitTileSubtitle(tester,
            l10n: l10n, diameterUnit: diameterUnit);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.diameterUnit, diameterUnit);
      }
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      final diameterUnit = settingsBloc.state.diameterUnit;
      await tapDiameterUnitTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(diameterUnitDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.diameterUnit, diameterUnit);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapDiameterUnitTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(diameterUnitDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose $diameterUnitNonDefault, exit screen, enter again',
        (tester) async {
      final diameterUnit = diameterUnitNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDiameterUnitTile(tester);
      await chooseDiameterUnit(tester, l10n: l10n, diameterUnit: diameterUnit);
      await verifyDiameterUnitTileSubtitle(tester,
          l10n: l10n, diameterUnit: diameterUnit);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.diameterUnit, diameterUnit);
      await tapBackButton(tester);
      await tapSettingsAction(tester);
      await verifyDiameterUnitTileSubtitle(tester,
          l10n: l10n, diameterUnit: diameterUnit);
      expect(settingsBloc.state.diameterUnit, diameterUnit);
    });
  });
}
