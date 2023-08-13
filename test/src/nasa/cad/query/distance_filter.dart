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

Finder getDropdownFinder(DistanceFilter filter) {
  return find.byKey(Key(
    '${CadScreen.distanceFilterKeyPrefix}'
    'dropdown_${filter.index}',
  ));
}

Future<void> tapDropdown(
  WidgetTester tester,
  DistanceFilter filter,
) async {
  await tester.tap(getDropdownFinder(filter));
  await tester.pumpAndSettle();
}

Finder getDropdownItemFinder(
  DistanceFilter filter,
  DistanceUnit unit,
) {
  final finder = find.byKey(
    Key(
      '${CadScreen.distanceFilterKeyPrefix}'
      'dropdown_item_${filter.index}_${unit.symbol}',
    ),
  );
  return finder.last;
}

Future<void> tapDropdownItem(
  WidgetTester tester,
  DistanceFilter filter,
  DistanceUnit unit,
) async {
  await tester.tap(getDropdownItemFinder(filter, unit), warnIfMissed: false);
  await tester.pumpAndSettle();
}

void expectText(
  WidgetTester tester,
  DistanceFilter filter,
  String text,
) {
  expect(
    tester.widget<TextField>(getTextFieldFinder(filter)).controller!.text,
    text,
  );
}

void expectDropdownValue(
  WidgetTester tester,
  DistanceFilter filter,
  DistanceUnit unit,
) {
  expect(
    tester
        .widget<DropdownButton<DistanceUnit>>(getDropdownFinder(filter))
        .value,
    unit,
  );
}

void expectDropdownValueFromState(
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
