import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/time_format_tile.dart';

void main() {
  group('$SettingsScreen ${l10n.timeFormat} Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      expect(timeFormatTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.timeFormatPattern,
          SettingsState.timeFormatPatternDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final timeFormatPattern in SettingsScreen.timeFormatPatterns) {
        await tapTimeFormatTile(tester);
        expect(timeFormatDialogFinder, findsOneWidget);
        await chooseTimeFormat(tester,
            l10n: l10n, timeFormatPattern: timeFormatPattern);
        expect(timeFormatDialogFinder, findsNothing);
        await verifyTimeFormatTileSubtitle(tester,
            l10n: l10n, timeFormatPattern: timeFormatPattern);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.timeFormatPattern, timeFormatPattern);
      }
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      final timeFormatPattern = settingsBloc.state.timeFormatPattern;
      await tapTimeFormatTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(timeFormatDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.timeFormatPattern, timeFormatPattern);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapTimeFormatTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(timeFormatDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose $timeFormatPatternNonDefault, exit screen, enter again',
        (tester) async {
      final timeFormatPattern = timeFormatPatternNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapTimeFormatTile(tester);
      await chooseTimeFormat(tester,
          l10n: l10n, timeFormatPattern: timeFormatPattern);
      await verifyTimeFormatTileSubtitle(tester,
          l10n: l10n, timeFormatPattern: timeFormatPattern);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.timeFormatPattern, timeFormatPattern);
      await tapBackButton(tester);
      await tapSettingsButton(tester);
      await verifyTimeFormatTileSubtitle(tester,
          l10n: l10n, timeFormatPattern: timeFormatPattern);
      expect(settingsBloc.state.timeFormatPattern, timeFormatPattern);
    });
  });
}
