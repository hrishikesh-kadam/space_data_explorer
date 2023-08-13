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
      expect(distanceFilterWidgetFinder, findsOneWidget);
      expectText(tester, DistanceFilter.min, minDistTextDefault.value!);
      expectText(tester, DistanceFilter.max, maxDistTextDefault.value!);
      expectDropdownValue(tester, DistanceFilter.min, minDistDefault.unit!);
      expectDropdownValue(tester, DistanceFilter.max, maxDistDefault.unit!);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRange, distRangeDefault);
      expect(state.distanceRangeText, distRangeTextDefault);
    });

    testWidgets('For max, select non-default unit, empty value, tap outside',
        (tester) async {
      const filter = DistanceFilter.max;
      const maxText = '';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tapDropdown(tester, filter);
      await tapDropdownItem(tester, filter, nonDefaultUnit);
      expectDropdownValue(tester, filter, nonDefaultUnit);
      expectDropdownValueFromState(filter, nonDefaultUnit);
      await tester.enterText(getTextFieldFinder(filter), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      expectText(tester, filter, maxDistTextDefault.value!);
      expectDropdownValue(tester, filter, maxDistDefault.unit!);
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxDistDefault.value);
      expect(state.distanceRangeText.end!.value, maxDistTextDefault.value);
      expectDropdownValueFromState(filter, maxDistDefault.unit!);
    });

    testWidgets('For max, enter .05 value, tap outside', (tester) async {
      const maxText = '.05';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
    });

    testWidgets('For max, enter .0 value, tap outside', (tester) async {
      const maxText = '.0';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
    });

    testWidgets('For max, enter . value, tap outside', (tester) async {
      const maxText = '.';
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
    });

    testWidgets('For max, empty and enter default value, tap outside',
        (tester) async {
      final maxText = maxDistTextDefault.value!;
      final maxValue = double.tryParse(maxText);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), '');
      await tester.enterText(getTextFieldFinder(DistanceFilter.max), maxText);
      CadState state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
      await tap(tester, finder: getTextFieldFinder(DistanceFilter.min));
      state = CadScreen.cadBloc!.state;
      expect(state.distanceRange.end!.value, maxValue);
      expect(state.distanceRangeText.end!.value, maxText);
    });

    testWidgets('Select every unit', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      for (final filter in DistanceFilter.values) {
        for (final unit in CadScreen.distanceFilterUnits) {
          await tapDropdown(tester, filter);
          await tapDropdownItem(tester, filter, unit);
          expectDropdownValue(tester, filter, unit);
          expectDropdownValueFromState(filter, unit);
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
        minDistTextNonDefault.value!,
      );
      await tapDropdown(tester, filter);
      await tapDropdownItem(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      await tester.enterText(
        getTextFieldFinder(filter),
        maxDistTextNonDefault.value!,
      );
      await tapDropdown(tester, filter);
      await tapDropdownItem(tester, filter, nonDefaultUnit);
      await ensureOutofViewport(tester);
      expect(distanceFilterWidgetFinder, findsNothing);
      await ensureFilterWidgetVisible(tester);
      expect(distanceFilterWidgetFinder, findsOneWidget);
      filter = DistanceFilter.min;
      expectText(tester, filter, minDistTextNonDefault.value!);
      expectDropdownValue(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      expectText(tester, filter, maxDistTextNonDefault.value!);
      expectDropdownValue(tester, filter, nonDefaultUnit);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRange, distRangeNonDefault);
      expect(state.distanceRangeText, distRangeTextNonDefault);
    });

    testWidgets('CadBloc prefilled, reset', (tester) async {
      final cadBloc = getCadBloc();
      cadBloc.add(CadDistanceRangeEvent(
        distanceRange: distRangeNonDefault,
        distanceRangeText: distRangeTextNonDefault,
      ));
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      DistanceFilter filter = DistanceFilter.min;
      expectText(tester, filter, minDistTextNonDefault.value!);
      expectDropdownValue(tester, filter, nonDefaultUnit);
      filter = DistanceFilter.max;
      expectText(tester, filter, maxDistTextNonDefault.value!);
      expectDropdownValue(tester, filter, nonDefaultUnit);
      cadBloc.add(CadDistanceRangeEvent(
        distanceRange: distRangeDefault,
        distanceRangeText: distRangeTextDefault,
      ));
      await tester.pumpAndSettle();
      filter = DistanceFilter.min;
      expectText(tester, filter, minDistTextDefault.value!);
      expectDropdownValue(tester, filter, defaultUnit);
      filter = DistanceFilter.max;
      expectText(tester, filter, maxDistTextDefault.value!);
      expectDropdownValue(tester, filter, defaultUnit);
    });

    testWidgets('verifyDistanceQueryParameters()', (tester) async {
      final distRangeEventList = [
        CadDistanceRangeEvent(
          distanceRange: distRangeDefault,
          distanceRangeText: distRangeTextDefault,
        ),
        CadDistanceRangeEvent(
          distanceRange: distRangeNonDefault,
          distanceRangeText: distRangeTextNonDefault,
        ),
      ];
      await pumpCadRouteAsInitialLocation(tester);
      for (int i = 0; i < distRangeEventList.length; i++) {
        CadScreen.cadBloc!.add(distRangeEventList[i]);
        await tester.pumpAndSettle();
        await verifyDistanceQueryParameters(
          tester,
          distRangeEventList[i].distanceRange,
        );
      }
    });
  });
}
