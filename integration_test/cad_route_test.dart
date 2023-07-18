import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'nasa_route_test.dart';
import 'space_data_explorer_app_test.dart';

Future<void> pumpCadRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: CadRoute.path);
  expect(find.byType(CadScreen), findsOneWidget);
}

Future<void> pumpCadRouteAsNormalLink(WidgetTester tester) async {
  await pumpNasaRouteAsNormalLink(tester);
  await tester.tap(find.byKey(NasaScreen.cadButtonKey));
  await tester.pumpAndSettle();
  expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(CadScreen), findsOneWidget);
}
