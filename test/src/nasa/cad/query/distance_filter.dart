import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../cad_route.dart';

enum DistanceFilter { min, max }

final distFilterWidgetFinder = find.byKey(CadScreen.distFilterKey);

const defaultUnit = SbdbCadQueryParameters.distUnitDefault;
final nonDefaultUnit = CadScreen.distFilterUnits.firstWhere(
  (unit) => unit != defaultUnit,
);
final distMinNonDefault = Distance(
  value: getNonDefaultValue(DistanceFilter.min),
  unit: nonDefaultUnit,
);
final distMaxNonDefault = Distance(
  value: getNonDefaultValue(DistanceFilter.max),
  unit: nonDefaultUnit,
);
final distRangeNonDefault = DistanceRange(
  start: distMinNonDefault,
  end: distMaxNonDefault,
);
final distMinTextNonDefault = ValueUnit<String, Never>(
  value: distMinNonDefault.value?.toString() ?? '',
);
final distMaxTextNonDefault = ValueUnit<String, Never>(
  value: distMaxNonDefault.value?.toString() ?? '',
);
final distRangeTextNonDefault = ValueRange<String, Never>(
  start: distMinTextNonDefault,
  end: distMaxTextNonDefault,
);

double getNonDefaultValue(DistanceFilter filter) {
  switch (filter) {
    case DistanceFilter.min:
      assert(1 != minDistDefault.value);
      return 1;
    case DistanceFilter.max:
      assert(2 != maxDistDefault.value);
      return 2;
  }
}

Finder getTextFieldFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distFilterKeyPrefix}'
    'text_field_${filter.index}',
  ));
}

Finder getUnitDropdownFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distFilterKeyPrefix}'
    'unit_dropdown_${filter.index}',
  ));
}

Finder getUnitTextFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distFilterKeyPrefix}'
    'unit_text_${filter.index}',
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
      'unit_dropdown_item_${filter.index}_${unit.symbol}',
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
  switch (filter) {
    case DistanceFilter.min:
      expect(state.distRange.start!.unit, unit);
    case DistanceFilter.max:
      expect(state.distRange.end!.unit, unit);
  }
}

void expectUnitText(
  WidgetTester tester,
  DistanceFilter filter,
  DistanceUnit unit,
) {
  expect(tester.widget<Text>(getUnitTextFinder(filter)).data, unit.symbol);
}

Future<void> ensureOutofViewport(WidgetTester tester) async {
  await tester.drag(
    customScrollViewFinder,
    Offset(0, -tester.view.getLogicalSize().height),
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
  DistanceRange distRange,
) async {
  await verifyQueryParameters(
    tester,
    const SbdbCadQueryParameters().copyWithDistRange(distRange),
  );
}
