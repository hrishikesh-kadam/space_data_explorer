import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/route/nasa_route.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_route.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../src/route/home/home_route.dart';
import '../../../src/space_data_explorer_app.dart';

void main() {
  group('$HomeRoute Navigation Test', () {
    testWidgets('Basic', (WidgetTester tester) async {
      await pumpHomeRoute(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Navigate to and from $NasaRoute', (WidgetTester tester) async {
      await pumpHomeRoute(tester);
      expect(find.byType(HomeScreen), findsOneWidget);
      await tapNasaItem(tester);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Deep-link', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue = HomeRoute.uri.path;
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Https URL with no path', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue =
          'https://domain.com';
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Https URL with no path, trailing slash', (tester) async {
      tester.platformDispatcher.defaultRouteNameTestValue =
          'https://domain.com/';
      await pumpApp(tester);
      tester.platformDispatcher.clearDefaultRouteNameTestValue();
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
