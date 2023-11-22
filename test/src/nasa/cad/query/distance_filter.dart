import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/value_range_filter_widget.dart';
import '../cad_route.dart';

enum DistanceFilter { min, max }

final Finder distFilterWidgetFinder = find.byKey(CadScreen.distFilterKey);
final Finder titleFinder = find.byKey(const Key(
  '${CadScreen.distFilterKeyPrefix}'
  '${ValueRangeFilterWidget.titleKey}',
));

const DistanceUnit defaultUnit = SbdbCadQueryParameters.distUnitDefault;
final DistanceUnit nonDefaultUnit = CadScreen.distFilterUnits.firstWhere(
  (unit) => unit != defaultUnit,
);

const Distance? distMinDefault = DistanceRangeState.distMinDefault;
const Distance? distMaxDefault = DistanceRangeState.distMaxDefault;
final List<double?> valueListDefault = DistanceRangeState.valueListDefault;
final List<String> textListDefault = DistanceRangeState.textListDefault;
final List<DistanceUnit> unitListDefault = DistanceRangeState.unitListDefault;

final Distance distMinNonDefault = Distance(
  value: getNonDefaultValue(DistanceFilter.min),
  unit: nonDefaultUnit,
);
final Distance distMaxNonDefault = Distance(
  value: getNonDefaultValue(DistanceFilter.max),
  unit: nonDefaultUnit,
);
final List<double> valueListNonDefault = [
  distMinNonDefault.value,
  distMaxNonDefault.value,
];
final List<String> textListNonDefault = [
  distMinNonDefault.value.toString(),
  distMaxNonDefault.value.toString(),
];
final List<DistanceUnit> unitListNonDefault = [
  distMinNonDefault.unit,
  distMaxNonDefault.unit,
];

double getNonDefaultValue(DistanceFilter filter) {
  switch (filter) {
    case DistanceFilter.min:
      assert(1 != DistanceRangeState.distMinDefault?.value);
      return 1;
    case DistanceFilter.max:
      assert(2 != DistanceRangeState.distMaxDefault?.value);
      return 2;
  }
}

Finder getTextFieldFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distFilterKeyPrefix}'
    '${ValueRangeFilterWidget.valueTextFieldKeyPrefix}'
    '${filter.index}_key',
  ));
}

Finder getUnitDropdownFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distFilterKeyPrefix}'
    '${ValueRangeFilterWidget.unitDropdownKeyPrefix}'
    '${filter.index}_key',
  ));
}

Finder getUnitTextFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distFilterKeyPrefix}'
    '${ValueRangeFilterWidget.unitTextKeyPrefix}'
    '${filter.index}_key',
  ));
}

Future<void> tapUnitDropdown(
  WidgetTester tester,
  DistanceFilter filter,
) async {
  await tester.tap(getUnitDropdownFinder(filter));
  await tester.pumpAndSettle();
}

Finder getUnitDropdownItemFinder(
  DistanceFilter filter,
  DistanceUnit unit,
) {
  final finder = find.byKey(
    Key(
      '${CadScreen.distFilterKeyPrefix}'
      '${ValueRangeFilterWidget.unitDropdownItemKeyPrefix}'
      '${filter.index}_${unit.symbol}_key',
    ),
  );
  return finder.last;
}

Future<void> tapUnitDropdownItem(
  WidgetTester tester,
  DistanceFilter filter,
  DistanceUnit unit,
) async {
  await tester.tap(
    getUnitDropdownItemFinder(filter, unit),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();
}

void expectValueText(
  WidgetTester tester,
  DistanceFilter filter,
  String text,
) {
  expect(
    tester.widget<TextField>(getTextFieldFinder(filter)).controller!.text,
    text,
  );
}

void expectUnitDropdownValue(
  WidgetTester tester,
  DistanceFilter filter,
  DistanceUnit unit,
) {
  expect(
    tester
        .widget<DropdownButton<DistanceUnit>>(getUnitDropdownFinder(filter))
        .value,
    unit,
  );
}

void expectUnitDropdownValueFromState(
  DistanceFilter filter,
  DistanceUnit unit,
) {
  final state = CadScreen.cadBloc!.state;
  expect(state.distanceRangeState.unitList[filter.index], unit);
}

void expectUnitText(
  WidgetTester tester,
  DistanceFilter filter,
  DistanceUnit unit,
) {
  expect(tester.widget<Text>(getUnitTextFinder(filter)).data, unit.symbol);
}

// TODO(hrishikesh-kadam): Scope of improvement
Future<void> ensureOutOfViewport(WidgetTester tester) async {
  await tester.drag(
    customScrollViewFinder,
    Offset(0, -tester.view.getLogicalSize().height * 1.5),
  );
  await tester.pumpAndSettle();
}

Future<void> ensureFilterWidgetVisible(WidgetTester tester) async {
  await scrollToTop(tester);
  await tester.dragUntilVisible(
    distFilterWidgetFinder,
    customScrollViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

Future<void> verifyDistQueryParameters(
  WidgetTester tester,
  Distance? min,
  Distance? max,
) async {
  await verifyQueryParameters(
    tester,
    const SbdbCadQueryParameters().copyWithDistanceRange(min, max),
  );
}
