import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/value_range_filter_widget.dart';
import '../../../src/nasa/cad/cad_route.dart';
import '../../../src/nasa/cad/query/distance_filter.dart' as src1;
import '../../../src/nasa/cad/query/distance_filter.dart';
import '../../../src/widgets/value_range_filter_widget.dart' as src2;
import '../../../src/widgets/value_range_filter_widget.dart';

void main() {
  group('$ValueRangeFilterWidget Interaction Test', () {
    testWidgets('Initial state with empty textList', (tester) async {
      final initialState = const CadState().copyWith(
          distanceRangeState: DistanceRangeState(
        valueList: valueListDefault,
        textList: ['', ''],
        unitList: unitListDefault,
      ));
      final cadBloc = getCadBloc(initialState: initialState);
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      const DistanceFilter filter = DistanceFilter.max;
      expectValueText(tester, filter, textListDefault[1]);
      src1.expectUnitDropdownValue(tester, filter, unitListDefault[1]);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList, valueListDefault);
      expect(state.distanceRangeState.textList, textListDefault);
      expect(state.distanceRangeState.unitList, unitListDefault);
    });

    testWidgets('Initial state with null valueList and empty textList',
        (tester) async {
      final initialState = const CadState().copyWith(
          distanceRangeState: DistanceRangeState(
        valueList: [null, null],
        textList: ['', ''],
        unitList: unitListDefault,
      ));
      final cadBloc = getCadBloc(initialState: initialState);
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      const DistanceFilter filter = DistanceFilter.max;
      expectValueText(tester, filter, textListDefault[1]);
      src1.expectUnitDropdownValue(tester, filter, unitListDefault[1]);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList, valueListDefault);
      expect(state.distanceRangeState.textList, textListDefault);
      expect(state.distanceRangeState.unitList, unitListDefault);
    });

    testWidgets('Only 1 unit', (tester) async {
      CadScreen.distFilterUnits.clear();
      CadScreen.distFilterUnits.add(
        SbdbCadQueryParameters.distUnitDefault,
      );
      await pumpCadRouteAsInitialLocation(tester);
      expectValueText(tester, DistanceFilter.min, textListDefault[0]);
      expectValueText(tester, DistanceFilter.max, textListDefault[1]);
      expectUnitText(tester, DistanceFilter.min, unitListDefault[0]);
      expectUnitText(tester, DistanceFilter.max, unitListDefault[1]);
    });

    testWidgets('No units', (tester) async {
      CadScreen.distFilterUnits.clear();
      await pumpCadRouteAsInitialLocation(tester);
      expectValueText(tester, DistanceFilter.min, textListDefault[0]);
      expectValueText(tester, DistanceFilter.max, textListDefault[1]);
      expect(getUnitTextFinder(DistanceFilter.min), findsNothing);
      expect(getUnitTextFinder(DistanceFilter.max), findsNothing);
      expect(src1.getUnitDropdownFinder(DistanceFilter.min), findsNothing);
      expect(src1.getUnitDropdownFinder(DistanceFilter.max), findsNothing);
    });

    testWidgets('Unit fallback', (tester) async {
      final units = {DistanceUnit.km, DistanceUnit.mi};
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: ValueRangeFilterWidget<double, DistanceUnit>(
            labels: const {'Start', 'End'},
            valueList: const [0.1, 0.2],
            textList: const ['.1', '.2'],
            valueParser: (text) => double.parse(text),
            units: units,
            unitSymbols: {DistanceUnit.km.symbol, DistanceUnit.mi.symbol},
          ),
        ),
      ));
      src2.expectUnitDropdownValue(tester, RangeFilter.start, units.first);
      src2.expectUnitDropdownValue(tester, RangeFilter.end, units.first);
    });
  });
}
