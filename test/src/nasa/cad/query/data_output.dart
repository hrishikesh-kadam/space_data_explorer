import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../cad_route.dart';

final dataOutputWidgetFinder = find.byKey(CadScreen.dataOutputKey);
final totalOnlyChipFinder = find.byKey(Key(
  '${CadScreen.dataOutputKeyPrefix}'
  '${DataOutput.totalOnly.name}',
));
final diameterChipFinder = find.byKey(Key(
  '${CadScreen.dataOutputKeyPrefix}'
  '${DataOutput.diameter.name}',
));
final fullnameChipFinder = find.byKey(Key(
  '${CadScreen.dataOutputKeyPrefix}'
  '${DataOutput.fullname.name}',
));

final Set<Finder> dataOutputChipFinders = CadScreen.dataOutputSet.map((e) {
  return find.byKey(Key(
    '${CadScreen.dataOutputKeyPrefix}'
    '${e.name}',
  ));
}).toSet();
final Map<DataOutput, Finder> dataOutputChipFinderMap = {
  for (var i = 0; i < CadScreen.dataOutputSet.length; i++)
    CadScreen.dataOutputSet.elementAt(i): dataOutputChipFinders.elementAt(i)
};

Future<void> ensureDataOutputWidgetVisible(WidgetTester tester) async {
  await tester.dragUntilVisible(
    dataOutputWidgetFinder,
    customScrollViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

Future<void> tapDataOutputChip(
  WidgetTester tester, {
  required DataOutput dataOutput,
}) async {
  await tester.tap(dataOutputChipFinderMap[dataOutput]!);
  await tester.pumpAndSettle();
}

void expectDataOutputSelected(
  WidgetTester tester,
  Set<DataOutput> dataOutputSet,
) {
  for (var i = 0; i < CadScreen.dataOutputSet.length; i++) {
    final finder = dataOutputChipFinders.elementAt(i);
    final matcher =
        dataOutputSet.contains(CadScreen.dataOutputSet.elementAt(i));
    expect(tester.widget<FilterChip>(finder).selected, matcher);
  }
}

Future<void> verifyDataOutputQueryParameters(
  WidgetTester tester,
  Set<DataOutput> dataOutputSet,
) async {
  await verifyQueryParameters(
    tester,
    const SbdbCadQueryParameters().copyWithDataOutput(dataOutputSet),
  );
}
