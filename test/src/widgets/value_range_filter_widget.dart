import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/widgets/value_range_filter_widget.dart';

enum RangeFilter { start, end }

Finder getUnitDropdownFinder(RangeFilter filter) {
  return find.byKey(Key(
    '${ValueRangeFilterWidget.unitDropdownKeyPrefix}' '${filter.index}_key',
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
