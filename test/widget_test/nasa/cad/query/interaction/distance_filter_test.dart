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
      expectValueText(tester, DistanceFilter.min, minDistTextDefault.value!);
      expectValueText(tester, DistanceFilter.max, maxDistTextDefault.value!);
      expectUnitDropdownValue(tester, DistanceFilter.min, minDistDefault.unit!);
      expectUnitDropdownValue(tester, DistanceFilter.max, maxDistDefault.unit!);
      final state = CadScreen.cadBloc!.state;
      expect(state.distRange, distRangeDefault);
      expect(state.distRangeText, distRangeTextDefault);
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
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      expectValueText(tester, filter, maxDistTextDefault.value!);
      expectUnitDropdownValue(tester, filter, maxDistDefault.unit!);
      state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxDistDefault.value);
      expect(state.distRangeText.end!.value, maxDistTextDefault.value);
      expectUnitDropdownValueFromState(filter, maxDistDefault.unit!);
    });

    testWidgets('For max, enter .05 value, tap outside', (tester) async {
      const maxText = '.05';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
    });

    testWidgets('For max, enter .0 value, tap outside', (tester) async {
      const maxText = '.0';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
    });

    testWidgets('For max, enter . value, tap outside', (tester) async {
      const maxText = '.';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
    });

    testWidgets('For max, empty and enter default value, tap outside',
        (tester) async {
      final maxText = maxDistTextDefault.value!;
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), '');
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distRange.end!.value, maxValue);
      expect(state.distRangeText.end!.value, maxText);
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
        distMinTextNonDefault.value!,
      );
      await tapUnitDropdown(tester, filter);
      await tapUnitDropdownItem(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      await tester.enterText(
        getTextFieldFinder(filter),
        distMaxTextNonDefault.value!,
      );
      await tapUnitDropdown(tester, filter);
      await tapUnitDropdownItem(tester, filter, nonDefaultUnit);
      await ensureOutofViewport(tester);
      expect(distFilterWidgetFinder, findsNothing);
      await ensureFilterWidgetVisible(tester);
      expect(distFilterWidgetFinder, findsOneWidget);
      filter = DistanceFilter.min;
      expectValueText(tester, filter, distMinTextNonDefault.value!);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      expectValueText(tester, filter, distMaxTextNonDefault.value!);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      final state = CadScreen.cadBloc!.state;
      expect(state.distRange, distRangeNonDefault);
      expect(state.distRangeText, distRangeTextNonDefault);
    });

    testWidgets('CadBloc prefilled, reset', (tester) async {
      final cadBloc = getCadBloc();
      cadBloc.add(CadDistRangeEvent(
        distRange: distRangeNonDefault,
        distRangeText: distRangeTextNonDefault,
      ));
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      DistanceFilter filter = DistanceFilter.min;
      expectValueText(tester, filter, distMinTextNonDefault.value!);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      expectValueText(tester, filter, distMaxTextNonDefault.value!);
      expectUnitDropdownValue(tester, filter, nonDefaultUnit);
      cadBloc.add(CadDistRangeEvent(
        distRange: distRangeDefault,
        distRangeText: distRangeTextDefault,
      ));
      await tester.pumpAndSettle();
      filter = DistanceFilter.min;
      expectValueText(tester, filter, minDistTextDefault.value!);
      expectUnitDropdownValue(tester, filter, minDistDefault.unit!);
      filter = DistanceFilter.max;
      expectValueText(tester, filter, maxDistTextDefault.value!);
      expectUnitDropdownValue(tester, filter, maxDistDefault.unit!);
    });

    testWidgets('verifyDistanceQueryParameters()', (tester) async {
      final distRangeEventList = [
        CadDistRangeEvent(
          distRange: distRangeDefault,
          distRangeText: distRangeTextDefault,
        ),
        CadDistRangeEvent(
          distRange: distRangeNonDefault,
          distRangeText: distRangeTextNonDefault,
        ),
      ];
      await pumpCadRouteAsInitialLocation(tester);
      for (int i = 0; i < distRangeEventList.length; i++) {
        CadScreen.cadBloc!.add(distRangeEventList[i]);
        await tester.pumpAndSettle();
        await verifyDistQueryParameters(
          tester,
          distRangeEventList[i].distRange,
        );
      }
    });
  });
}
