import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';

final distanceFilterWidgetFinder = find.byKey(CadScreen.distanceFilterKey);
final minTextFieldFinder = find.byKey(const Key(
  '${CadScreen.distanceFilterKeyPrefix}'
  'text_field_0',
));
final maxTextFieldFinder = find.byKey(const Key(
  '${CadScreen.distanceFilterKeyPrefix}'
  'text_field_1',
));
final minDropdownFinder = find.byKey(const Key(
  '${CadScreen.distanceFilterKeyPrefix}'
  'dropdown_0',
));
final maxDropdownFinder = find.byKey(const Key(
  '${CadScreen.distanceFilterKeyPrefix}'
  'dropdown_1',
));
final auFinder = find.byKey(Key(
  '${CadScreen.distanceFilterKeyPrefix}'
  'dropdown_item_${DistanceUnit.au.symbol}',
));
final ldFinder = find.byKey(Key(
  '${CadScreen.distanceFilterKeyPrefix}'
  'dropdown_item_${DistanceUnit.ld.symbol}',
));

// Future<void> tap(
//   WidgetTester tester, {
//   required Finder finder,
// }) async {
//   await tester.tap(finder);
//   await tester.pumpAndSettle();
// }

void expectText(
  WidgetTester tester,
  Finder textFieldFinder,
  String text,
) {
  final controller = tester.widget<TextField>(textFieldFinder).controller!;
  expect(controller.text, text);
}

void expectDropdownValue(
  WidgetTester tester,
  Finder dropdownFinder,
  DistanceUnit unit,
) {
  expect(
    tester.widget<DropdownButton<DistanceUnit>>(dropdownFinder).value,
    unit,
  );
}
