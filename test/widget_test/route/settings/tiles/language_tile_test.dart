import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/language/language.dart';
import 'package:space_data_explorer/route/settings/bloc/settings_bloc.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../globals.dart';
import '../../../../route/settings/settings_route.dart';

void main() {
  group('$SettingsScreen ${l10n.language} Tile Widget Test', () {
    final tileFinder = find.byKey(SettingsScreen.languageTileKey);
    final dialogFinder = find.byKey(SettingsScreen.languageDialogKey);

    testWidgets('Basic', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(tileFinder, findsOneWidget);
      expect(settingsBloc.state.language, Language.system);
    });

    testWidgets('Choose ${Language.english}', (tester) async {
      const language = Language.english;
      await pumpSettingsRouteAsNormalLink(tester);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);
      await tester.tap(find.byKey(Key(language.displayName!)));
      await tester.pumpAndSettle();
      expect(dialogFinder, findsNothing);
      // LABEL: eligible-hrk_flutter_test_batteries subTitleTextFinder()
      final subTitleFinder = find.descendant(
        of: tileFinder,
        matching: find.text(language.displayName!),
      );
      expect(subTitleFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.language, language);
    });

    testWidgets('Choose ${Language.hindi}', (tester) async {
      const language = Language.hindi;
      await pumpSettingsRouteAsNormalLink(tester);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);
      await tester.tap(find.byKey(Key(language.displayName!)));
      await tester.pumpAndSettle();
      expect(dialogFinder, findsNothing);
      final subTitleFinder = find.descendant(
        of: tileFinder,
        matching: find.text(language.displayName!),
      );
      expect(subTitleFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.language, language);
    });

    testWidgets('Choose ${Language.marathi}', (tester) async {
      const language = Language.marathi;
      await pumpSettingsRouteAsNormalLink(tester);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);
      await tester.tap(find.byKey(Key(language.displayName!)));
      await tester.pumpAndSettle();
      expect(dialogFinder, findsNothing);
      final subTitleFinder = find.descendant(
        of: tileFinder,
        matching: find.text(language.displayName!),
      );
      expect(subTitleFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.language, language);
    });

    testWidgets('Choose ${Language.system}', (tester) async {
      const language = Language.system;
      await pumpSettingsRouteAsNormalLink(tester);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);
      await tester.tap(find.byKey(Key(l10n.system)));
      await tester.pumpAndSettle();
      expect(dialogFinder, findsNothing);
      final subTitleFinder = find.descendant(
        of: tileFinder,
        matching: find.text(l10n.system),
      );
      expect(subTitleFinder, findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.language, language);
    });

    testWidgets('System Locale Changed', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);
      final platformLocales = tester.platformDispatcher.locales;
      final changedPlatformLocales = List.of(platformLocales, growable: true);
      changedPlatformLocales.add(Locale(Language.hindi.code));
      tester.platformDispatcher.localesTestValue = changedPlatformLocales;
      await tester.pumpAndSettle();
      expect(dialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.language, Language.system);
    });

    testWidgets('Tap and dismiss without choosing any value', (tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      final settingsBloc = navigatorKey.currentContext!.read<SettingsBloc>();
      expect(settingsBloc.state.isAnyDialogShown, null);
      await tester.tap(tileFinder);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, true);
      await tester.tap(tileFinder, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(dialogFinder, findsNothing);
      expect(find.byType(SettingsScreen), findsOneWidget);
      expect(settingsBloc.state.isAnyDialogShown, false);
      expect(settingsBloc.state.language, Language.system);
    });
  });
}
