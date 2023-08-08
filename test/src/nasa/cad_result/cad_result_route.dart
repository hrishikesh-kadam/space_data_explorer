import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import '../../space_data_explorer_app.dart';
import '../cad/cad_route.dart';

Future<void> pumpCadResultRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: CadResultRoute.path);
}

Future<void> pumpCadResultRouteAsNormalLink(WidgetTester tester) async {
  await pumpCadRouteAsNormalLink(tester);
  await tapSearchButton(tester);
  await tester.pumpAndSettle();
}
