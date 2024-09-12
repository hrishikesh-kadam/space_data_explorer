import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../space_data_explorer_app.dart';
import '../cad/cad_route.dart';

final zeroCountTextFinder = find.byKey(CadResultScreen.zeroCountTextKey);
final totalTextFinder = find.byKey(CadResultScreen.totalTextKey);
final resultGridFinder = find.byKey(CadResultScreen.gridKey);
const resultGridItemRegExp = '${CadResultScreen.gridItemKeyPrefix}'
    '\\d+_';
final RegExp resultGridItemContainerKeyPattern = RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.gridItemContainerKeySuffix}',
);
final resultGridItemsFinder =
    find.byKeyContains(resultGridItemContainerKeyPattern);

Finder getResultGridItemFinder(int index) {
  return find.byKey(CadResultScreen.getGridItemContainerKey(index));
}

final desFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.desKeyPrefix}key',
));
final orbitIdFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.orbitIdKeyPrefix}key',
));
final jdFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.jdKeyPrefix}key',
));
final cdFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.cdKeyPrefix}key',
));
final distFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.distKeyPrefix}key',
));
final distMinFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.distMinKeyPrefix}key',
));
final distMaxFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.distMaxKeyPrefix}key',
));
final vRelFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.vRelKeyPrefix}key',
));
final vInfFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.vInfKeyPrefix}key',
));
final tSigmaFFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.tSigmaFKeyPrefix}key',
));
final bodyFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.bodyKeyPrefix}key',
));
final hFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.hKeyPrefix}key',
));
final diameterFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.diameterKeyPrefix}key',
));
final diameterSigmaFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.diameterSigmaKeyPrefix}key',
));
final fullnameFinder = find.byKeyContains(RegExp(
  '$resultGridItemRegExp'
  '${CadResultScreen.fullnameKeyPrefix}key',
));

Future<void> pumpCadResultRouteAsInitialLocation(
  WidgetTester tester, {
  JsonMap? $extra,
}) async {
  CadResultRoute.$extraTest = $extra;
  await pumpApp(tester, initialLocation: CadResultRoute.uri.path);
}

Future<void> pumpCadResultRouteAsNormalLink(WidgetTester tester) async {
  await pumpCadRouteAsNormalLink(tester);
  await tapSearchButton(tester);
}
