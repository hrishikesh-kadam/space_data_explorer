import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_query_widget.dart';

final smallBodyFilterWidgetFinder = find.byKey(const Key(
  '${CadScreen.smallBodyFilterKeyPrefix}'
  '${ChoiceChipQueryWidget.defaultKey}',
));
final Set<Finder> smallBodyChipFinders = CadScreen.smallBodySet.map((e) {
  return find.byKey(Key(
    '${CadScreen.smallBodyFilterKeyPrefix}'
    '${e.name}',
  ));
}).toSet();
final Map<SmallBody, Finder> smallBodyChipFinderMap = {
  for (var i = 0; i < CadScreen.smallBodySet.length; i++)
    CadScreen.smallBodySet.elementAt(i): smallBodyChipFinders.elementAt(i)
};

Future<void> tapSmallBody(
  WidgetTester tester, {
  required SmallBody smallBody,
}) async {
  await tester.tap(smallBodyChipFinderMap[smallBody]!);
  await tester.pumpAndSettle();
}

void expectSmallBodySelected(
  WidgetTester tester, {
  required SmallBody smallBody,
}) {
  for (var i = 0; i < CadScreen.smallBodySet.length; i++) {
    final finder = smallBodyChipFinders.elementAt(i);
    final matcher = smallBody == CadScreen.smallBodySet.elementAt(i);
    expect(tester.widget<ChoiceChip>(finder).selected, matcher);
  }
}
