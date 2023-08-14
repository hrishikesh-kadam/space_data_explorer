import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/value_range_filter_widget.dart';
import '../../src/nasa/cad/cad_route.dart';
import '../../src/nasa/cad/query/distance_filter.dart';

void main() {
  group('$ValueRangeFilterWidget Interaction Test', () {
    testWidgets('Initial state with empty rangeText', (tester) async {
      final cadBloc = getCadBloc(initialState: const CadState());
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      const DistanceFilter filter = DistanceFilter.max;
      expectValueText(tester, filter, maxDistTextDefault.value!);
      expectUnitDropdownValue(tester, filter, maxDistDefault.unit!);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRange, distRangeDefault);
      expect(state.distanceRangeText, distRangeTextDefault);
    });

    testWidgets('Initial state with null range and empty rangeText',
        (tester) async {
      final initialState = const CadState().copyWith(
        distanceRange: const DistanceRange(
          start: Distance(),
          end: Distance(),
        ),
      );
      final cadBloc = getCadBloc(initialState: initialState);
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      const DistanceFilter filter = DistanceFilter.max;
      expectValueText(tester, filter, maxDistTextDefault.value!);
      expectUnitDropdownValue(tester, filter, maxDistDefault.unit!);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRange, distRangeDefault);
      expect(state.distanceRangeText, distRangeTextDefault);
    });

    testWidgets('Only 1 unit', (tester) async {
      CadScreen.distanceFilterUnits.clear();
      CadScreen.distanceFilterUnits.add(
        SbdbCadQueryParameters.defaultDistanceUnit,
      );
      await pumpCadRouteAsInitialLocation(tester);
      expectValueText(tester, DistanceFilter.min, minDistTextDefault.value!);
      expectValueText(tester, DistanceFilter.max, maxDistTextDefault.value!);
      expectUnitText(tester, DistanceFilter.min, minDistDefault.unit!);
      expectUnitText(tester, DistanceFilter.max, maxDistDefault.unit!);
    });

    testWidgets('No units', (tester) async {
      CadScreen.distanceFilterUnits.clear();
      await pumpCadRouteAsInitialLocation(tester);
      expectValueText(tester, DistanceFilter.min, minDistTextDefault.value!);
      expectValueText(tester, DistanceFilter.max, maxDistTextDefault.value!);
      expect(getUnitTextFinder(DistanceFilter.min), findsNothing);
      expect(getUnitTextFinder(DistanceFilter.max), findsNothing);
      expect(getUnitDropdownFinder(DistanceFilter.min), findsNothing);
      expect(getUnitDropdownFinder(DistanceFilter.max), findsNothing);
    });
  });
}
