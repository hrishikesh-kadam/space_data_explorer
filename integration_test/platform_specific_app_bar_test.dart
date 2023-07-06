import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/config/config.dart';
import 'package:space_data_explorer/nasa/cad_page.dart';
import 'package:space_data_explorer/nasa/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_page.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import 'cad_page_test.dart';
import 'globals.dart';
import 'nasa_page_test.dart';
import 'space_data_explorer_app_test.dart';
import 'test_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  platformSpecificAppBarTest();
}

void platformSpecificAppBarTest() {
  // TODO(hrishikesh-kadam): Test stucks even after passing all tests.
  // Skipping deep-link tests for Web Integration Test.
  // File an issue someday.
  bool skipDeepLinkTests = kIsWeb;

  group('getPlatformSpecificAppBar() $testType Test', () {
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
      final cadPageBackButton = find.byType(BackButton);
      await tester.tap(cadPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(3, 1);
      }
      final nasaPageBackButton = find.byType(BackButton);
      await tester.tap(nasaPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(3, 0);
      }
    });

    testWidgets('2 pages down and 1 page up', (tester) async {
      await pumpNasaPageAsNormalLink(tester);
      final nasaPageBackButton = find.byType(BackButton);
      await tester.tap(nasaPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 0);
      }
    });

    testWidgets('deep-link to 3rd level and press back',
        skip: skipDeepLinkTests, (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = CadPage.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      final cadPageBackButton = find.byType(BackButton);
      await tester.tap(cadPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 1);
      }
    });

    testWidgets('deep-link to 2nd level and press back',
        skip: skipDeepLinkTests, (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NasaPage.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      final nasaPageBackButton = find.byType(BackButton);
      await tester.tap(nasaPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 1);
      }
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
      final cadPageBackButton = find.byType(BackButton);
      await tester.tap(cadPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      // In case of web this would be normal navigation because
      // there is no check for extra
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 0);
      }
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
      final cadPageBackButton = find.byType(BackButton);
      await tester.tap(cadPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      // In case of web this would be normal navigation because
      // there is no check for extra
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 0);
      }
    });
  });
}
