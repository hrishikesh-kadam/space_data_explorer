import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/route/nasa_route.dart';
import 'package:space_data_explorer/nasa/route/nasa_screen.dart';
import '../../route/home/home_route.dart';
import '../../space_data_explorer_app.dart';

final cadButtonFinder = find.byKey(NasaScreen.cadButtonKey);
final nonExistingPathButtonFinder =
    find.byKey(NasaScreen.nonExistingPathButtonKey);

Future<void> pumpNasaRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: NasaRoute.path);
}

Future<void> pumpNasaRouteAsNormalLink(WidgetTester tester) async {
  await pumpHomeRoute(tester);
  await tapNasaButton(tester);
}

Future<void> tapCadButton(WidgetTester tester) async {
  await tester.tap(cadButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> tapNonExistingPathButton(WidgetTester tester) async {
  await tester.tap(nonExistingPathButtonFinder);
  await tester.pumpAndSettle();
}
