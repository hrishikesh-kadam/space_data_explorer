import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../space_data_explorer_app.dart';
import '../cad/cad_route.dart';

Future<void> pumpCadResultRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: CadResultRoute.path);
  expect(find.byType(CadScreen), findsOneWidget);
}

Future<void> pumpCadResultRouteAsNormalLink(WidgetTester tester) async {
  await pumpCadRouteAsNormalLink(tester);
  await tester.tap(find.byKey(CadScreen.searchButtonKey));
  await tester.pumpAndSettle();
  expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
  expect(find.byType(CadResultScreen), findsOneWidget);
}