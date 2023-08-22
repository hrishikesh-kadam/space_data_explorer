import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../cad_route.dart';

final smallBodyFilterWidgetFinder = find.byKey(CadScreen.smallBodyFilterKey);
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

Future<void> ensureFilterWidgetVisible(WidgetTester tester) async {
  await tester.dragUntilVisible(
    smallBodyFilterWidgetFinder,
    customScrollViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

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

void expectChipsEnabled(
  WidgetTester tester, [
  bool enabled = true,
]) {
  for (var i = 0; i < CadScreen.smallBodySet.length; i++) {
    final finder = smallBodyChipFinders.elementAt(i);
    expect(tester.widget<ChoiceChip>(finder).isEnabled, enabled);
  }
}
