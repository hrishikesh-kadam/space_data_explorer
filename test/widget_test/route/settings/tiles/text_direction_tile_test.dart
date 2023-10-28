import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/text_direction_tile.dart';

void main() {
  group('$SettingsScreen $TextDirection Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await ensureTileVisible(tester, textDirectionTileFinder);
      expect(textDirectionTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(
          settingsBloc.state.textDirection, SettingsState.textDirectionDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final textDirection in SettingsScreen.textDirections) {
        await tapTextDirectionTile(tester);
        expect(textDirectionDialogFinder, findsOneWidget);
        await chooseTextDirection(tester,
            l10n: l10n, textDirection: textDirection);
        expect(textDirectionDialogFinder, findsNothing);
        await verifyTextDirectionTileSubtitle(tester,
            l10n: l10n, textDirection: textDirection);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.textDirection, textDirection);
      }
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      final textDirection = settingsBloc.state.textDirection;
      await tapTextDirectionTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(textDirectionDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.textDirection, textDirection);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapTextDirectionTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(textDirectionDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose $textDirectionNonDefault, exit screen, enter again',
        (tester) async {
      final textDirection = textDirectionNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapTextDirectionTile(tester);
      await chooseTextDirection(tester,
          l10n: l10n, textDirection: textDirection);
      await verifyTextDirectionTileSubtitle(tester,
          l10n: l10n, textDirection: textDirection);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.textDirection, textDirection);
      await tapBackButton(tester);
      await tapSettingsAction(tester);
      await ensureTileVisible(tester, textDirectionTileFinder);
      await verifyTextDirectionTileSubtitle(tester,
          l10n: l10n, textDirection: textDirection);
      expect(settingsBloc.state.textDirection, textDirection);
    });
  });
}
