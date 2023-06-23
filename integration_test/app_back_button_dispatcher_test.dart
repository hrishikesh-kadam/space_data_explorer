import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/config/configure_app.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/pages/nasa_source/nasa_source_page.dart';
import 'package:space_data_explorer/pages/nasa_source/nasa_source_screen.dart';
import 'package:space_data_explorer/pages/nasa_source/neows_page.dart';
import 'package:space_data_explorer/pages/nasa_source/neows_screen.dart';
import 'globals.dart';
import 'nasa_source_page_test.dart';
import 'neows_page_test.dart';
import 'space_data_explorer_app_test.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  appBackButtonDispatcherTest();
}

void appBackButtonDispatcherTest() {
  group('AppBackButtonDispatcher $testType Test', () {
    setUpAll(() {
      configureApp();
    });

    setUp(() {
      if (kIsWeb) {
        resetNavigationHistoryState();
      }
    });

    testWidgets('3 pages down and 2 pages up', (tester) async {
      await pumpNeowsPageAsNormalLink(tester);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaSourceScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('2 pages down and 1 page up', (tester) async {
      await pumpNasaSourcePageAsNormalLink(tester);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to 3rd level and press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NeowsPage.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(
          find.byType(NasaSourceScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NeowsScreen), findsOneWidget);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to 2nd level and press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NasaSourcePage.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaSourceScreen), findsOneWidget);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets(
        '3 pages down and 1 page up but extra without the isNormalLink key',
        (tester) async {
      GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'appKey');
      await pumpApp(
        tester,
        navigatorKey: navigatorKey,
      );
      expect(find.byType(HomeScreen), findsOneWidget);
      GoRouter.of(navigatorKey.currentContext!).go(NeowsPage.path, extra: {});
      await tester.pumpAndSettle();
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('3 pages down and 1 page up but when extra is not a Map',
        (tester) async {
      GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'appKey');
      await pumpApp(
        tester,
        navigatorKey: navigatorKey,
      );
      expect(find.byType(HomeScreen), findsOneWidget);
      GoRouter.of(navigatorKey.currentContext!).go(NeowsPage.path, extra: []);
      await tester.pumpAndSettle();
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Pump app and press back', (tester) async {
      await pumpApp(tester);
      await verifySystemNavigatorPop(tester);
    });
  });
}
