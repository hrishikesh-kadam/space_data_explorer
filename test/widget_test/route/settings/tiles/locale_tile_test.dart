import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_state.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/config/hydrated_bloc.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/locale_tile.dart';

void main() {
  group('$SettingsScreen $Locale Tile Widget Test', () {
    testWidgets('No interaction', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await ensureTileVisible(tester, localeTileFinder);
      expect(localeTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.locale, SettingsState.localeDefault);
    });

    testWidgets('Choose each', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      for (final locale in SettingsScreen.locales) {
        await tapLocaleTile(tester);
        expect(localeDialogFinder, findsOneWidget);
        await chooseLocale(tester, l10n: l10n, locale: locale);
        expect(localeDialogFinder, findsNothing);
        await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
        final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
        expect(settingsBloc.state.locale, locale);
      }
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      final locale = settingsBloc.state.locale;
      await tapLocaleTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(localeDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.locale, locale);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapLocaleTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tapAt(Offset.zero);
      await tester.pumpAndSettle();
      expect(localeDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets('Choose $localeNonDefault, exit screen, enter again',
        (tester) async {
      final locale = localeNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.locale, locale);
      await tapBackButton(tester);
      await tapSettingsAction(tester);
      await ensureTileVisible(tester, localeTileFinder);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
      expect(settingsBloc.state.locale, locale);
    });

    testWidgets(
        'With Hydration, Choose $localeNonDefault, exit app, enter again',
        (tester) async {
      final storageDirectory = Directory(
        'build/test/widget_test/route/settings/tiles/storage',
      );
      // Stucks in setUpHydratedBloc()
      await setUpHydratedBloc(storageDirectory);
      final locale = localeNonDefault;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.locale, locale);
      await tapBackButton(tester);
      await simulateAndroidBackButton(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      runApp(Container(key: UniqueKey()));
      await tester.pump();
      await pumpSettingsRouteAsNormalLink(tester, navigatorKey: GlobalKey());
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
      expect(settingsBloc.state.locale, locale);
      await tearDownHydratedBloc(storageDirectory);
    }, skip: true);
  });
}
