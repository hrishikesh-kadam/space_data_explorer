import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_filter_widget.dart';

final closeApproachBodyFilterWidgetFinder = find.byKey(const Key(
  '${CadScreen.closeApproachBodyFilterKeyPrefix}'
  '${ChoiceChipFilterWidget.defaultKey}',
));

final List<Finder> closeApproachBodyChipFinders =
    CadScreen.closeApproachBodyList.map((e) {
  return find.byKey(Key(
    '${CadScreen.closeApproachBodyFilterKeyPrefix}'
    '${e.name}',
  ));
}).toList();

final Map<CloseApproachBody, Finder> closeApproachBodyChipFinderMap = {
  for (var i = 0; i < CadScreen.closeApproachBodyList.length; i++)
    CadScreen.closeApproachBodyList[i]: closeApproachBodyChipFinders[i]
};

Future<void> tapCloseApproachBody(
  WidgetTester tester, {
  required CloseApproachBody closeApproachBody,
}) async {
  await tester.tap(closeApproachBodyChipFinderMap[closeApproachBody]!);
  await tester.pumpAndSettle();
}

void expectCloseApproachBodySelected(
  WidgetTester tester, {
  required CloseApproachBody closeApproachBody,
}) {
  for (var i = 0; i < CadScreen.closeApproachBodyList.length; i++) {
    final finder = closeApproachBodyChipFinders[i];
    final matcher = closeApproachBody == CadScreen.closeApproachBodyList[i];
    expect(tester.widget<ChoiceChip>(finder).selected, matcher);
  }
}
