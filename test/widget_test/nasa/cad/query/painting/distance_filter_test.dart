import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/value_range_filter_widget.dart';
import '../../../../../constants/dimensions.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/distance_filter.dart';

void main() {
  group(
      '$CadRoute ${ValueRangeFilterWidget<double, DistanceUnit>} Painting Test',
      () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: Dimensions.galaxyFoldPortraitWidth);
      await pumpCadRouteAsInitialLocation(tester);
      tester.expectNoOverflow(of: distFilterWidgetFinder);
      for (final filter in DistanceFilter.values) {
        for (final unit in CadScreen.distFilterUnits) {
          await tapUnitDropdown(tester, filter);
          tester.expectNoOverflow(of: distFilterWidgetFinder);
          await tapUnitDropdownItem(tester, filter, unit);
          tester.expectNoOverflow(of: distFilterWidgetFinder);
        }
      }
    });
  });
}
