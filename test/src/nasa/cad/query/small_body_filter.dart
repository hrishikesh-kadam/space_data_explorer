import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../cad_route.dart';

final smallBodyFilterWidgetFinder = find.byKey(CadScreen.smallBodyFilterKey);
final Set<Finder> smallBodyFilterChipFinders = CadScreen.smallBodySet.map((e) {
  return find.byKey(Key(
    '${CadScreen.smallBodyFilterKeyPrefix}'
    '${e.name}',
  ));
}).toSet();
final Map<SmallBodyFilter, Finder> smallBodyFilterChipFinderMap = {
  for (var i = 0; i < CadScreen.smallBodySet.length; i++)
    CadScreen.smallBodySet.elementAt(i): smallBodyFilterChipFinders.elementAt(i)
};

Future<void> ensureFilterWidgetVisible(WidgetTester tester) async {
  await tester.dragUntilVisible(
    smallBodyFilterWidgetFinder,
    customScrollViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

Future<void> tapSmallBodyFilter(
  WidgetTester tester, {
  required SmallBodyFilter smallBodyFilter,
}) async {
  await tester.tap(smallBodyFilterChipFinderMap[smallBodyFilter]!);
  await tester.pumpAndSettle();
}

void expectSmallBodyFilterSelected(
  WidgetTester tester, {
  required SmallBodyFilter smallBodyFilter,
}) {
  for (var i = 0; i < CadScreen.smallBodySet.length; i++) {
    final finder = smallBodyFilterChipFinders.elementAt(i);
    final matcher = smallBodyFilter == CadScreen.smallBodySet.elementAt(i);
    expect(tester.widget<ChoiceChip>(finder).selected, matcher);
  }
}

void expectChipsEnabled(
  WidgetTester tester, [
  bool enabled = true,
]) {
  for (var i = 0; i < CadScreen.smallBodySet.length; i++) {
    final finder = smallBodyFilterChipFinders.elementAt(i);
    expect(tester.widget<ChoiceChip>(finder).isEnabled, enabled);
  }
}
