import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/route/nasa_route.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../src/config/config.dart';
import '../../src/globals.dart';
import '../../src/helper/helper.dart';
import '../../src/nasa/cad/cad_route.dart';
import '../../src/nasa/route/nasa_route.dart';
import '../../src/space_data_explorer_app.dart';

void main() {
  appBarBackButtonTest();
}

// Reason to skip: extra to CadRoute is now type-safe.
// Enable again once we have a 3rd level route without type-safe extra.
bool skipExtraNotMapTests = true;

void appBarBackButtonTest() {
  // TODO(hrishikesh-kadam): Test stucks even after passing all tests.
  // Skipping deep-link tests for Web Integration Test.
  // File an issue someday.
  bool skipDeepLinkTests = kIsWeb;

  group('getAppBarBackButtonTest() $testType Test', () {
    setUpAll(() {
      configureApp();
    });

    setUp(() {
      if (kIsWeb) {
        resetNavigationHistoryState();
      }
    });

    testWidgets('3 routes down and 2 routes up', (tester) async {
      await pumpCadRouteAsNormalLink(tester);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(3, 1);
      }
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(3, 0);
      }
    });

    testWidgets('2 routes down and 1 route up', (tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 0);
      }
    });

    testWidgets('deep-link to 3rd level and press back',
        skip: skipDeepLinkTests, (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = CadRoute.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 1);
      }
    });

    testWidgets('deep-link to 2nd level and press back',
        skip: skipDeepLinkTests, (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NasaRoute.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 1);
      }
    });

    testWidgets(
        '3 routes down and 1 route up but extra without the isNormalLink key',
        (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      const CadRoute($extra: {}).go(navigatorKey.currentContext!);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      // In case of web this would be normal navigation because
      // there is no check for extra
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 0);
      }
    });

    testWidgets('3 routes down and 1 route up but when extra is not a Map',
        skip: skipExtraNotMapTests, (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      GoRouter.of(navigatorKey.currentContext!).go(CadRoute.path, extra: []);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      // In case of web this would be normal navigation because
      // there is no check for extra
      if (kIsWeb) {
        verifyHistoryLengthAndSerialCount(2, 0);
      }
    });

    testWidgets('2 routes down and 1 route up but when extra is not a Map',
        (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      GoRouter.of(navigatorKey.currentContext!).go(NasaRoute.path, extra: []);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
