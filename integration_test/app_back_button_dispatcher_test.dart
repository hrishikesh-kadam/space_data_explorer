import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/config/config.dart';
import 'package:space_data_explorer/nasa/cad_page.dart';
import 'package:space_data_explorer/nasa/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_page.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import 'cad_page_test.dart';
import 'globals.dart';
import 'nasa_source_page_test.dart';
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
      await pumpCadPageAsNormalLink(tester);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('2 pages down and 1 page up', (tester) async {
      await pumpNasaSourcePageAsNormalLink(tester);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to 3rd level and press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = CadPage.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to 2nd level and press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NasaPage.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
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
      GoRouter.of(navigatorKey.currentContext!).go(CadPage.path, extra: {});
      await tester.pumpAndSettle();
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
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
      GoRouter.of(navigatorKey.currentContext!).go(CadPage.path, extra: []);
      await tester.pumpAndSettle();
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Pump app and press back', (tester) async {
      await pumpApp(tester);
      await verifySystemNavigatorPop(tester);
    });
  });
}
