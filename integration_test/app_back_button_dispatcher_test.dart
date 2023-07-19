import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'app_bar_back_button_test.dart';
import 'cad_route_test.dart';
import 'config.dart';
import 'globals.dart';
import 'nasa_route_test.dart';
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

    testWidgets('3 routes down and 2 routes up', (tester) async {
      await pumpCadRouteAsNormalLink(tester);
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

    testWidgets('2 routes down and 1 route up', (tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to 3rd level and press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = CadRoute.path;
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
      tester.platformDispatcher.defaultRouteNameTestValue = NasaRoute.path;
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
        '3 routes down and 1 route up but extra without the isNormalLink key',
        (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      const CadRoute($extra: {}).go(navigatorKey.currentContext!);
      await tester.pumpAndSettle();
      await simulateAndroidBackButton(tester);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('3 routes down and 1 route up but when extra is not a Map',
        skip: skipExtraNotMapTests, (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      GoRouter.of(navigatorKey.currentContext!).go(CadRoute.path, extra: []);
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
