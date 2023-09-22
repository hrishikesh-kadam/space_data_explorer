import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

enum RangeFilter { start, end }

Finder getUnitDropdownFinder(RangeFilter filter) {
  return find.byKey(Key(
    'unit_dropdown_${filter.index}',
  ));
}

void expectUnitDropdownValue<U>(
  WidgetTester tester,
  RangeFilter filter,
  U unit,
) {
  expect(
    tester.widget<DropdownButton<U>>(getUnitDropdownFinder(filter)).value,
    unit,
  );
}
