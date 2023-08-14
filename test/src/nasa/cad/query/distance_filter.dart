import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../cad_route.dart';

enum DistanceFilter { min, max }

final distanceFilterWidgetFinder = find.byKey(CadScreen.distanceFilterKey);

const defaultUnit = SbdbCadQueryParameters.defaultDistanceUnit;
final nonDefaultUnit = CadScreen.distanceFilterUnits.firstWhere(
  (unit) => unit != SbdbCadQueryParameters.defaultDistanceUnit,
);
final minDistNonDefault = Distance(
  value: getNonDefaultValue(DistanceFilter.min),
  unit: nonDefaultUnit,
);
final maxDistNonDefault = Distance(
  value: getNonDefaultValue(DistanceFilter.max),
  unit: nonDefaultUnit,
);
final distRangeNonDefault = DistanceRange(
  start: minDistNonDefault,
  end: maxDistNonDefault,
);
final minDistTextNonDefault = ValueUnit<String, void>(
  value: minDistNonDefault.value?.toString() ?? '',
);
final maxDistTextNonDefault = ValueUnit<String, void>(
  value: maxDistNonDefault.value?.toString() ?? '',
);
final distRangeTextNonDefault = ValueRange<String, void>(
  start: minDistTextNonDefault,
  end: maxDistTextNonDefault,
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
    '${CadScreen.distanceFilterKeyPrefix}'
    'text_field_${filter.index}',
  ));
}

Finder getUnitDropdownFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distanceFilterKeyPrefix}'
    'unit_dropdown_${filter.index}',
  ));
}

Finder getUnitTextFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distanceFilterKeyPrefix}'
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
      '${CadScreen.distanceFilterKeyPrefix}'
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
      expect(state.distanceRange.start!.unit, unit);
    case DistanceFilter.max:
      expect(state.distanceRange.end!.unit, unit);
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
    distanceFilterWidgetFinder,
    customScrollViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

Future<void> verifyDistanceQueryParameters(
  WidgetTester tester,
  DistanceRange distanceRange,
) async {
  await verifyQueryParameters(
    tester,
    const SbdbCadQueryParameters().copyWithDistanceRange(distanceRange),
  );
}
