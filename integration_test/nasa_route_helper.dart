import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import 'home_route_helper.dart';
import 'space_data_explorer_app_test.dart';

Future<void> pumpNasaRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: NasaRoute.path);
  expect(find.byType(NasaScreen), findsOneWidget);
}

Future<void> pumpNasaRouteAsNormalLink(WidgetTester tester) async {
  await pumpHomeRoute(tester);
  await tester.tap(find.byKey(HomeScreen.nasaButtonKey));
  await tester.pumpAndSettle();
  expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(NasaScreen), findsOneWidget);
}