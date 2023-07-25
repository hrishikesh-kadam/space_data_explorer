import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/date_format_pattern.dart';
import 'package:space_data_explorer/route/settings/language.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../src/globals.dart';
import '../../../../src/route/settings/settings_route.dart';

final dateFormatTileFinder = find.byKey(SettingsScreen.dateFormatTileKey);
final dateFormatDialogFinder = find.byKey(SettingsScreen.dateFormatDialogKey);

void main() {
  group('$SettingsScreen ${l10n.dateFormat} Tile Widget Test', () {
    testWidgets('Basic', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      expect(dateFormatTileFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.dateFormatPattern, DateFormatPattern.yMd);
    });

    testWidgets('Choose ${DateFormatPattern.ddMMyyyy}', (tester) async {
      const dateFormatPattern = DateFormatPattern.ddMMyyyy;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
    });

    testWidgets('Choose ${DateFormatPattern.MMddyyyy}', (tester) async {
      const dateFormatPattern = DateFormatPattern.MMddyyyy;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
    });

    testWidgets('Choose ${DateFormatPattern.yyyyMMdd}', (tester) async {
      const dateFormatPattern = DateFormatPattern.yyyyMMdd;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
    });

    testWidgets('Choose ${DateFormatPattern.yMd}', (tester) async {
      const dateFormatPattern = DateFormatPattern.yMd;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDateFormatTile(tester);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(Locale(Language.hindi.code));
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(dateFormatDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tapDateFormatTile(tester);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tap(find.byType(AppBar), warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(dateFormatDialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
    });

    testWidgets(
        'Choose ${DateFormatPattern.ddMMyyyy}, exit screen, enter again',
        (tester) async {
      const dateFormatPattern = DateFormatPattern.ddMMyyyy;
      await pumpSettingsRouteAsNormalLink(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
      await tapBackButton(tester);
      await tapSettingsButton(tester);
      await verifyDateFormatTileSubtitle(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
    });
  });
}

Future<void> tapDateFormatTile(WidgetTester tester) async {
  await tester.tap(dateFormatTileFinder);
  await tester.pumpAndSettle();
  expect(dateFormatDialogFinder, findsOneWidget);
}

Future<void> chooseDateFormat(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DateFormatPattern dateFormatPattern,
}) async {
  await tester.tap(find.byKey(Key(SettingsScreen.getDateFormatValueTitle(
    l10n: l10n,
    dateFormatPattern: dateFormatPattern,
  ))));
  await tester.pumpAndSettle();
  expect(dateFormatDialogFinder, findsNothing);
}

Future<void> verifyDateFormatTileSubtitle(
  WidgetTester tester, {
  required AppLocalizations l10n,
  required DateFormatPattern dateFormatPattern,
}) async {
  final subTitleFinder = find.descendant(
    of: dateFormatTileFinder,
    matching: find.text(
      SettingsScreen.getDateFormatValueTitle(
        l10n: l10n,
        dateFormatPattern: dateFormatPattern,
      ),
    ),
  );
  expect(subTitleFinder, findsOneWidget);
}
