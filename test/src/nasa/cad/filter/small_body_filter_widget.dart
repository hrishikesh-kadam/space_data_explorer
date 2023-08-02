import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_filter_widget.dart';

final smallBodyFilterWidgetFinder = find.byKey(
    const Key('${CadScreen.keyPrefix}${ChoiceChipFilterWidget.defaultKey}'));

final List<Finder> smallBodyChipFinders = CadScreen.smallBodyList.map((e) {
  return find.byKey(Key('${CadScreen.keyPrefix}${e.toString()}'));
}).toList();

final Map<SmallBody, Finder> smallBodyChipFinderMap = {
  for (var i = 0; i < CadScreen.smallBodyList.length; i++)
    CadScreen.smallBodyList[i]: smallBodyChipFinders[i]
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
  for (var i = 0; i < CadScreen.smallBodyList.length; i++) {
    final finder = smallBodyChipFinders[i];
    final matcher = smallBody == CadScreen.smallBodyList[i];
    expect(tester.widget<ChoiceChip>(finder).selected, matcher);
  }
}
