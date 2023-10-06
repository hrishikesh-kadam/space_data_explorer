import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/config/app_back_button_dispatcher.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/route/nasa_route.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_route.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/route/page_not_found/page_not_found_route.dart';
import 'package:space_data_explorer/route/page_not_found/page_not_found_screen.dart';
import '../../src/config/config.dart';
import '../../src/globals.dart';
import '../../src/nasa/cad/cad_route.dart';
import '../../src/nasa/route/nasa_route.dart';
import '../../src/route/page_not_found/page_not_found_route.dart';
import '../../src/space_data_explorer_app.dart';
import 'app_bar_back_button_test.dart';

void main() {
  appBackButtonDispatcherTest();
}

void appBackButtonDispatcherTest() {
  group('$AppBackButtonDispatcher $testType Test', () {
    setUpAll(() async {
      await configureApp();
    });

    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await goNonExistingPath(tester);
    });

    testWidgets('2 routes forward, 1 route back', (tester) async {
      await pumpCadRouteAsNormalLink(tester);
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('1 route forward, 1 route back', (tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('1 route forward, go non-existing-path, press back',
        (tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await goNonExistingPath(tester);
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsNothing);
      expect(find.byType(HomeScreen, skipOffstage: false), findsNothing);
      await simulateAndroidBackButton(tester);
      expect(find.byType(PageNotFoundScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(NasaScreen), findsNothing);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('2 routes forward, go non-existing-path, press back',
        (tester) async {
      await pumpCadRouteAsNormalLink(tester);
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await goNonExistingPath(tester);
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
      expect(find.byType(CadScreen, skipOffstage: false), findsNothing);
      expect(find.byType(NasaScreen, skipOffstage: false), findsNothing);
      expect(find.byType(HomeScreen, skipOffstage: false), findsNothing);
      await simulateAndroidBackButton(tester);
      expect(find.byType(PageNotFoundScreen), findsNothing);
      expect(find.byType(CadScreen, skipOffstage: false), findsNothing);
      expect(find.byType(CadScreen, skipOffstage: false), findsNothing);
      expect(find.byType(NasaScreen, skipOffstage: false), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('deep-link to 3rd level route, press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = CadRoute.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('deep-link to 2nd level route, press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NasaRoute.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('deep-link to non-existing-page, press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue =
          PageNotFoundRoute.nonExistingPath;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsNothing);
      await simulateAndroidBackButton(tester);
      expect(find.byType(PageNotFoundScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets(
        '2 routes forward, 1 route back but extra without the isNormalLink key',
        (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      const CadRoute($extra: {}).go(navigatorKey.currentContext!);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('2 routes forward, 1 route back but when extra is not a Map',
        skip: skipExtraNotMapTests, (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      navigatorKey.currentContext!.go(CadRoute.path, extra: []);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('1 route forward, 1 route back but when extra is not a Map',
        (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      navigatorKey.currentContext!.go(NasaRoute.path, extra: []);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await simulateAndroidBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      await verifySystemNavigatorPop(tester);
    });

    testWidgets('Pump app and press back', (tester) async {
      await pumpApp(tester);
      await verifySystemNavigatorPop(tester);
    });
  });
}
