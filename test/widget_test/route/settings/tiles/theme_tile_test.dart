import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import 'package:space_data_explorer/route/settings/theme_data.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/theme_data_tile.dart';

void main() {
  group('$SettingsScreen $ThemeData Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await ensureTileVisible(tester, themeDataTileFinder);
      expect(themeDataTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.themeData, SettingsState.themeDataDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final themeData in SettingsScreen.themeDatas) {
        await tapThemeDataTile(tester);
        expect(themeDataDialogFinder, findsOneWidget);
        await chooseThemeData(tester, l10n: l10n, themeData: themeData);
        expect(themeDataDialogFinder, findsNothing);
        await verifyThemeDataTileSubtitle(tester,
            l10n: l10n, themeData: themeData);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.themeData, themeData);
      }
    });

    testWidgets('System $ThemeMode Changed', (tester) async {
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapThemeDataTile(tester);
      await chooseThemeData(tester,
          l10n: l10n, themeData: ThemeDataExt.systemThemeModePreferred);
      ThemeData currentThemeMode =
          Theme.of(tester.element(find.byType(SettingsScreen)));
      // TODO(hrishikesh-kadam): Feature request for String name in ThemeData
      expect(
        currentThemeMode.colorScheme,
        ThemeDataExt.defaultBright.colorScheme,
      );
      tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
      await tester.pumpAndSettle();
      currentThemeMode = Theme.of(navigatorKey.currentContext!);
      expect(
        currentThemeMode.colorScheme,
        ThemeDataExt.defaultDark.colorScheme,
      );
      tester.platformDispatcher.clearPlatformBrightnessTestValue();
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapThemeDataTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(themeDataDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose themeDataNonDefault, exit screen, enter again',
        (tester) async {
      final themeData = themeDataNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapThemeDataTile(tester);
      await chooseThemeData(tester, l10n: l10n, themeData: themeData);
      await verifyThemeDataTileSubtitle(tester,
          l10n: l10n, themeData: themeData);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.themeData, themeData);
      await tapBackButton(tester);
      await tapSettingsAction(tester);
      await ensureTileVisible(tester, themeDataTileFinder);
      await verifyThemeDataTileSubtitle(tester,
          l10n: l10n, themeData: themeData);
      expect(settingsBloc.state.themeData, themeData);
    });
  });
}
