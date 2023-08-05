import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/widgets/choice_chip_input_widget.dart';

final smallBodySelectorWidgetFinder = find.byKey(const Key(
  '${CadScreen.smallBodySelectorKeyPrefix}'
  '${ChoiceChipInputWidget.defaultKey}',
));
final titleFinder = find.byKey(const Key(
  '${CadScreen.smallBodySelectorKeyPrefix}'
  '${ChoiceChipInputWidget.titleKey}',
));
final spkIdChipFinder = find.byKey(Key(
  '${CadScreen.smallBodySelectorKeyPrefix}'
  '${SmallBodySelector.spkId.name}',
));
final designationChipFinder = find.byKey(Key(
  '${CadScreen.smallBodySelectorKeyPrefix}'
  '${SmallBodySelector.designation.name}',
));
final textFieldFinder = find.byKey(const Key(
  '${CadScreen.smallBodySelectorKeyPrefix}'
  '${ChoiceChipInputWidget.textFieldKey}',
));

Finder getSmallBodyFinder(
  SmallBodySelector smallBodySelector,
) {
  return switch (smallBodySelector) {
    SmallBodySelector.spkId => spkIdChipFinder,
    SmallBodySelector.designation => designationChipFinder,
  };
}

Future<void> tapSmallBodySelector(
  WidgetTester tester,
  SmallBodySelector smallBodySelector,
) async {
  await tester.tap(getSmallBodyFinder(smallBodySelector));
  await tester.pumpAndSettle();
}

void expectSmallBodySelectorSelected(
  WidgetTester tester,
  SmallBodySelector smallBodySelector, [
  bool expected = true,
]) {
  final finder = getSmallBodyFinder(smallBodySelector);
  expect(tester.widget<ChoiceChip>(finder).selected, expected);
}

void expectSmallBodySelectorNotSelected(
  WidgetTester tester,
  SmallBodySelector smallBodySelector,
) {
  expectSmallBodySelectorSelected(
    tester,
    smallBodySelector,
    false,
  );
}
