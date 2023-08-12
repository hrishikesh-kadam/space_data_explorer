import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/value_range_filter_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/distance_filter.dart';

void main() {
  group(
      '$CadRoute ${ValueRangeFilterWidget<double, DistanceUnit>} '
      'Interaction Test', () {
    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No Interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(distanceFilterWidgetFinder, findsOneWidget);
      expectText(tester, minTextFieldFinder, minDistTextDefault.value!);
      expectText(tester, maxTextFieldFinder, maxDistTextDefault.value!);
      expectDropdownValue(tester, minDropdownFinder, minDistDefault.unit!);
      expectDropdownValue(tester, maxDropdownFinder, maxDistDefault.unit!);
      final state = CadScreen.cadBloc!.state;
      expect(state.distanceRange, defaultDistanceRange);
      expect(state.distanceTextRange, defaultDistaceTextRange);
    });
  });
}
