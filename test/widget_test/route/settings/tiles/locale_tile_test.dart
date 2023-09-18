import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/locale.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/config/hydrated_bloc.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../../src/route/settings/tiles/locale_tile.dart';

void main() {
  group('$SettingsScreen $Locale Tile Widget Test', () {
    testWidgets('Basic', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      expect(localeTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.locale, null);
    });

    testWidgets('Choose ${LocaleExt.en}', (tester) async {
      const locale = LocaleExt.en;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      expect(localeDialogFinder, findsOneWidget);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      expect(localeDialogFinder, findsNothing);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
    });

    testWidgets('Choose ${LocaleExt.hi}', (tester) async {
      const locale = LocaleExt.hi;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
    });

    testWidgets('Choose ${LocaleExt.mr}', (tester) async {
      const locale = LocaleExt.mr;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
    });

    testWidgets('Choose ${l10n.system}', (tester) async {
      const locale = null;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(LocaleExt.hi);
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(localeDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
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

    testWidgets('Choose ${LocaleExt.en}, exit screen, enter again',
        (tester) async {
      const locale = LocaleExt.en;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
      await tapBackButton(tester);
      await tapSettingsButton(tester);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
    });

    testWidgets('With Hydration, Choose ${LocaleExt.en}, exit app, enter again',
        (tester) async {
      final storageDirectory = Directory(
        'build/test/widget_test/route/settings/tiles/storage',
      );
      // Stucks in setUpHydratedBloc()
      await setUpHydratedBloc(storageDirectory);
      const locale = LocaleExt.en;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapLocaleTile(tester);
      await chooseLocale(tester, l10n: l10n, locale: locale);
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
      await tapBackButton(tester);
      await simulateAndroidBackButton(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      runApp(Container(key: UniqueKey()));
      await tester.pump();
      await pumpSettingsRouteAsNormalLink(tester, navigatorKey: GlobalKey());
      await verifyLocaleTileSubtitle(tester, l10n: l10n, locale: locale);
      await tearDownHydratedBloc(storageDirectory);
    }, skip: true);
  });
}