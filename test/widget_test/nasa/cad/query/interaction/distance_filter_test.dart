import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/value_range_filter_widget.dart';
import '../../../../../constants/dimensions.dart';
import '../../../../../src/helper/helper.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/distance_filter.dart';

void main() {
  group(
      '$CadRoute ${ValueRangeFilterWidget<double, DistanceUnit>} Interaction Test',
      () {
    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No Interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(distFilterWidgetFinder, findsOneWidget);
      expectValueText(tester, DistanceFilter.min, textListDefault[0]);
      expectValueText(tester, DistanceFilter.max, textListDefault[1]);
      expectUnitDropdownValue(tester, DistanceFilter.min, unitListDefault[0]);
      expectUnitDropdownValue(tester, DistanceFilter.max, unitListDefault[1]);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList, valueListDefault);
      expect(state.distanceRangeState.textList, textListDefault);
      expect(state.distanceRangeState.unitList, unitListDefault);
    });

    testWidgets('For max, select non-default unit, empty value, tap outside',
        (tester) async {
      const filter = DistanceFilter.max;
      const maxText = '';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tapUnitDropdown(tester, filter);
      await tapUnitDropdownItem(tester, filter, nonDefaultUnit);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      expectUnitDropdownValueFromState(filter, nonDefaultUnit);
      await tester.enterText(getTextFieldFinder(filter), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      expectValueText(tester, filter, textListDefault[1]);
      expectUnitDropdownValue(tester, filter, unitListDefault[1]);
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], valueListDefault[1]);
      expect(state.distanceRangeState.textList[1], textListDefault[1]);
      expectUnitDropdownValueFromState(filter, unitListDefault[1]);
    });

    testWidgets('For max, enter .05 value, tap outside', (tester) async {
      const maxText = '.05';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
    });

    testWidgets('For max, enter .0 value, tap outside', (tester) async {
      const maxText = '.0';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
    });

    testWidgets('For max, enter . value, tap outside', (tester) async {
      const maxText = '.';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
    });

    testWidgets('For max, empty and enter default value, tap outside',
        (tester) async {
      final maxText = textListDefault[1];
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), '');
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList[1], maxValue);
      expect(state.distanceRangeState.textList[1], maxText);
    });

    testWidgets('Select every unit', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      for (final filter in DistanceFilter.values) {
        for (final unit in CadScreen.distFilterUnits) {
          await tapUnitDropdown(tester, filter);
          await tapUnitDropdownItem(tester, filter, unit);
          expectUnitDropdownValue(tester, filter, unit);
          expectUnitDropdownValueFromState(filter, unit);
        }
      }
    });

    testWidgets('Re-entering viewport', (tester) async {
      tester.view.setLogicalSize(
        width: Dimensions.galaxyFoldPortraitWidth,
        height: Dimensions.galaxyFoldPortraitHeight,
      );
      await pumpCadRouteAsInitialLocation(tester);
      DistanceFilter filter = DistanceFilter.min;
      await tester.enterText(
        getTextFieldFinder(filter),
        textListNonDefault[0],
      );
      await tapUnitDropdown(tester, filter);
      await tapUnitDropdownItem(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      await tester.enterText(
        getTextFieldFinder(filter),
        textListNonDefault[1],
      );
      await tapUnitDropdown(tester, filter);
      await tapUnitDropdownItem(tester, filter, nonDefaultUnit);
      await ensureOutOfViewport(tester);
      expect(distFilterWidgetFinder, findsNothing);
      await ensureFilterWidgetVisible(tester);
      expect(distFilterWidgetFinder, findsOneWidget);
      filter = DistanceFilter.min;
      expectValueText(tester, filter, textListNonDefault[0]);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      expectValueText(tester, filter, textListNonDefault[1]);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRangeState.valueList, valueListNonDefault);
      expect(state.distanceRangeState.textList, textListNonDefault);
      expect(state.distanceRangeState.unitList, unitListNonDefault);
    });

    testWidgets('disableInputs', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      DistanceFilter filter = DistanceFilter.min;
      expect(getTextFieldFinder(filter).hitTestable().evaluate().length, 1);
      expect(getUnitDropdownFinder(filter).hitTestable().evaluate().length, 1);
      filter = DistanceFilter.max;
      expect(getTextFieldFinder(filter).hitTestable().evaluate().length, 1);
      expect(getUnitDropdownFinder(filter).hitTestable().evaluate().length, 1);
      await emitDisableInputs(tester);
      filter = DistanceFilter.min;
      expect(getTextFieldFinder(filter).hitTestable().evaluate().length, 0);
      expect(getUnitDropdownFinder(filter).hitTestable().evaluate().length, 0);
      filter = DistanceFilter.max;
      expect(getTextFieldFinder(filter).hitTestable().evaluate().length, 0);
      expect(getUnitDropdownFinder(filter).hitTestable().evaluate().length, 0);
    });

    testWidgets('CadBloc prefilled, reset', (tester) async {
      final cadBloc = getCadBloc();
      cadBloc.add(CadDistanceEvent(
        valueList: valueListNonDefault,
        textList: textListNonDefault,
        unitList: unitListNonDefault,
      ));
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      DistanceFilter filter = DistanceFilter.min;
      expectValueText(tester, filter, textListNonDefault[0]);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      expectValueText(tester, filter, textListNonDefault[1]);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      cadBloc.add(CadDistanceEvent(
        valueList: valueListDefault,
        textList: textListDefault,
        unitList: unitListDefault,
      ));
      await tester.pumpAndSettle();
      filter = DistanceFilter.min;
      expectValueText(tester, filter, textListDefault[0]);
      expectUnitDropdownValue(tester, filter, unitListDefault[0]);
      filter = DistanceFilter.max;
      expectValueText(tester, filter, textListDefault[1]);
      expectUnitDropdownValue(tester, filter, unitListDefault[1]);
    });

    testWidgets('verifyDistanceQueryParameters()', (tester) async {
      final distRangeEventList = [
        CadDistanceEvent(
          valueList: valueListDefault,
          textList: textListDefault,
          unitList: unitListDefault,
        ),
        CadDistanceEvent(
          valueList: valueListNonDefault,
          textList: textListNonDefault,
          unitList: unitListNonDefault,
        ),
      ];
      await pumpCadRouteAsInitialLocation(tester);
      for (int i = 0; i < distRangeEventList.length; i++) {
        CadScreen.cadBloc!.add(distRangeEventList[i]);
        await tester.pumpAndSettle();
        final Distance? distMin = CadBloc.constructDistance(
          value: distRangeEventList[i].valueList[0],
          unit: distRangeEventList[i].unitList[0],
        );
        final Distance? distMax = CadBloc.constructDistance(
          value: distRangeEventList[i].valueList[1],
          unit: distRangeEventList[i].unitList[1],
        );
        await verifyDistQueryParameters(tester, distMin, distMax);
      }
    });
  });
}
