import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../extension/common_finders.dart';
import '../../space_data_explorer_app.dart';
import '../cad/cad_route.dart';

final zeroCountTextFinder = find.byKey(CadResultScreen.zeroCountTextKey);
final resultGridFinder = find.byKey(CadResultScreen.gridKey);
final resultGridItemFinder = find.descendant(
  of: resultGridFinder,
  matching: find.byKeyStartsWith(CadResultScreen.gridItemKeyPrefix),
);

Future<void> pumpCadResultRouteAsInitialLocation(
  WidgetTester tester, {
  JsonMap? $extra,
}) async {
  CadResultRoute.$extraTest = $extra;
  await pumpApp(tester, initialLocation: CadResultRoute.path);
}

Future<void> pumpCadResultRouteAsNormalLink(WidgetTester tester) async {
  await pumpCadRouteAsNormalLink(tester);
  await tapSearchButton(tester);
}
