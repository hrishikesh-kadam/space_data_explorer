import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../cad_route.dart';

final closeApproachBodySelectorWidgetFinder =
    find.byKey(CadScreen.closeApproachBodySelectorKey);
final Set<Finder> closeApproachBodyChipFinders =
    CadScreen.closeApproachBodySet.map((e) {
  return find.byKey(Key(
    '${CadScreen.closeApproachBodySelectorKeyPrefix}'
    '${e.name}',
  ));
}).toSet();
final Map<CloseApproachBody, Finder> closeApproachBodyChipFinderMap = {
  for (var i = 0; i < CadScreen.closeApproachBodySet.length; i++)
    CadScreen.closeApproachBodySet.elementAt(i):
        closeApproachBodyChipFinders.elementAt(i)
};

Future<void> ensureSelectorWidgetVisible(WidgetTester tester) async {
  await tester.dragUntilVisible(
    closeApproachBodySelectorWidgetFinder,
    customScrollViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

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
  for (var i = 0; i < CadScreen.closeApproachBodySet.length; i++) {
    final finder = closeApproachBodyChipFinders.elementAt(i);
    final matcher =
        closeApproachBody == CadScreen.closeApproachBodySet.elementAt(i);
    expect(tester.widget<ChoiceChip>(finder).selected, matcher);
  }
}

Future<void> verifyCloseApproachBodyQueryParameters(
  WidgetTester tester,
  CloseApproachBody? closeApproachBody,
) async {
  await verifyQueryParameters(
    tester,
    SbdbCadQueryParameters(body: closeApproachBody),
  );
}
