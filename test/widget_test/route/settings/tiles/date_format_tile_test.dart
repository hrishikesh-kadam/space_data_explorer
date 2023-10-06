import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/date_format_tile.dart';

void main() {
  group('$SettingsScreen ${l10n.dateFormat} Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      expect(dateFormatTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.dateFormatPattern,
          SettingsState.dateFormatPatternDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final dateFormatPattern in SettingsScreen.dateFormatPatterns) {
        await tapDateFormatTile(tester);
        expect(dateFormatDialogFinder, findsOneWidget);
        await chooseDateFormat(tester,
            l10n: l10n, dateFormatPattern: dateFormatPattern);
        expect(dateFormatDialogFinder, findsNothing);
        await verifyDateFormatTileSubtitle(tester,
            l10n: l10n, dateFormatPattern: dateFormatPattern);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.dateFormatPattern, dateFormatPattern);
      }
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      final dateFormatPattern = settingsBloc.state.dateFormatPattern;
      await tapDateFormatTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(dateFormatDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.dateFormatPattern, dateFormatPattern);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapDateFormatTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(dateFormatDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose $dateFormatPatternNonDefault, exit screen, enter again',
        (tester) async {
      final dateFormatPattern = dateFormatPatternNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.dateFormatPattern, dateFormatPattern);
      await tapBackButton(tester);
      await tapSettingsAction(tester);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      expect(settingsBloc.state.dateFormatPattern, dateFormatPattern);
    });
  });
}
