import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/widgets/choice_chip_input_widget.dart';

final smallBodySelectorWidgetFinder =
    find.byKey(CadScreen.smallBodySelectorKey);
final titleFinder = find.byKey(const Key(
  '${CadScreen.smallBodySelectorKeyPrefix}'
  '${ChoiceChipInputWidget.titleKey}',
));
final Set<Finder> smallBodySelectorChipFinders =
    CadScreen.smallBodySelectors.map((e) {
  return find.byKey(Key(
    '${CadScreen.smallBodySelectorKeyPrefix}'
    '${e.name}',
  ));
}).toSet();
final Map<SmallBodySelector, Finder> smallBodySelectorChipFinderMap = {
  for (var i = 0; i < CadScreen.smallBodySelectors.length; i++)
    CadScreen.smallBodySelectors.elementAt(i):
        smallBodySelectorChipFinders.elementAt(i)
};
final textFieldFinder = find.byKey(const Key(
  '${CadScreen.smallBodySelectorKeyPrefix}'
  '${ChoiceChipInputWidget.textFieldKey}',
));
const String designation = '2023 HK';
const int spkId = 54354503;

Future<void> tapSmallBodySelector(
  WidgetTester tester,
  SmallBodySelector smallBodySelector,
) async {
  await tester.tap(smallBodySelectorChipFinderMap[smallBodySelector]!);
  await tester.pumpAndSettle();
}

void expectSmallBodySelectorSelected(
  WidgetTester tester,
  SmallBodySelector? smallBodySelector,
) {
  for (final entry in smallBodySelectorChipFinderMap.entries) {
    final expected = smallBodySelector == entry.key;
    expect(tester.widget<ChoiceChip>(entry.value).selected, expected);
  }
}

void expectSmallBodySelectorState(
  SmallBodySelectorState expectedState,
) {
  expect(
    CadScreen.cadBloc!.state.smallBodySelectorState,
    expectedState,
  );
}
