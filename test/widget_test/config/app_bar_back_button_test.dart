import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
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

// ignore: directives_ordering
import '../../src/helper/helper_non_web.dart'
    if (dart.library.html) '../../src/helper/helper_web.dart' as platform;

void main() {
  appBarBackButtonTest();
}

// Reason to skip: extra to CadRoute is now type-safe.
// Enable again once we have a 3rd level route without type-safe extra.
bool skipExtraNotMapTests = true;

void appBarBackButtonTest() {
  group('getAppBarBackButtonTest() $testType Test', () {
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
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('1 route forward, 1 route back', (tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
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
      await tapBackButton(tester);
      expect(find.byType(PageNotFoundScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(NasaScreen), findsNothing);
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
      await tapBackButton(tester);
      expect(find.byType(PageNotFoundScreen), findsNothing);
      expect(find.byType(CadScreen, skipOffstage: false), findsNothing);
      expect(find.byType(CadScreen, skipOffstage: false), findsNothing);
      expect(find.byType(NasaScreen, skipOffstage: false), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to 3rd level route, press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = CadRoute.uri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to 2nd level route, press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = NasaRoute.uri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('deep-link to non-existing-page, press back', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue =
          PageNotFoundRoute.nonExistingUri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(PageNotFoundScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsNothing);
      await tapBackButton(tester);
      expect(find.byType(PageNotFoundScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
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
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('2 routes forward, 1 route back but when extra is not a Map',
        skip: skipExtraNotMapTests, (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      navigatorKey.currentContext!.go(CadRoute.uri.path, extra: []);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('1 route forward, 1 route back but when extra is not a Map',
        (tester) async {
      await pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      navigatorKey.currentContext!.go(NasaRoute.uri.path, extra: []);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Browser forward on Route with extra and redirect',
        skip: !kIsWeb, (tester) async {
      await pumpCadRouteAsNormalLink(tester);
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      await tapSearchButton(tester);
      platform.historyBack();
      await tester.pumpAndSettle();
      platform.historyForward();
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadResultScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(CadScreen), findsOneWidget);
      expect(find.byType(CadResultScreen), findsNothing);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsOneWidget);
      expect(find.byType(CadScreen), findsNothing);
    });
  });
}
