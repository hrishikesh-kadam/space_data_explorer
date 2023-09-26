import 'package:flutter/foundation.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

import 'package:space_data_explorer/nasa/cad_result/cad_result_route.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../extension/common_finders.dart';
import '../../space_data_explorer_app.dart';
import '../cad/cad_route.dart';

final zeroCountTextFinder = find.byKey(CadResultScreen.zeroCountTextKey);
final totalTextFinder = find.byKey(CadResultScreen.totalTextKey);
final resultGridFinder = find.byKey(CadResultScreen.gridKey);
final resultGridItemsFinder =
    find.byKeyStartsWith(CadResultScreen.gridItemContainerKeyPrefix);

Finder getResultGridItemFinder(int index) {
  return find.byKey(Key(
    '${CadResultScreen.gridItemContainerKeyPrefix}$index',
  ));
}

final desLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.desKeyPrefix}label_');
final orbitIdLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.orbitIdKeyPrefix}label_');
final jdLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.jdKeyPrefix}label_');
final cdLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.cdKeyPrefix}label_');
final distLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.distKeyPrefix}label_');
final distMinLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.distMinKeyPrefix}label_');
final distMaxLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.distMaxKeyPrefix}label_');
final vRelLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.vRelKeyPrefix}label_');
final vInfLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.vInfKeyPrefix}label_');
final tSigmaFLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.tSigmaFKeyPrefix}label_');
final bodyLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.bodyKeyPrefix}label_');
final hLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.hKeyPrefix}label_');
final diameterLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.diameterKeyPrefix}label_');
final diameterSigmaLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.diameterSigmaKeyPrefix}label_');
final fullnameLabelFinder =
    find.byKeyStartsWith('${CadResultScreen.fullnameKeyPrefix}label_');

final desDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.desKeyPrefix}display_value_');
final orbitIdDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.orbitIdKeyPrefix}display_value_');
final jdDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.jdKeyPrefix}display_value_');
final cdDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.cdKeyPrefix}display_value_');
final distDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.distKeyPrefix}display_value_');
final distMinDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.distMinKeyPrefix}display_value_');
final distMaxDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.distMaxKeyPrefix}display_value_');
final vRelDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.vRelKeyPrefix}display_value_');
final vInfDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.vInfKeyPrefix}display_value_');
final tSigmaFDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.tSigmaFKeyPrefix}display_value_');
final bodyDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.bodyKeyPrefix}display_value_');
final hDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.hKeyPrefix}display_value_');
final diameterDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.diameterKeyPrefix}display_value_');
final diameterSigmaDisplayValueFinder = find
    .byKeyStartsWith('${CadResultScreen.diameterSigmaKeyPrefix}display_value_');
final fullnameDisplayValueFinder =
    find.byKeyStartsWith('${CadResultScreen.fullnameKeyPrefix}display_value_');

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
