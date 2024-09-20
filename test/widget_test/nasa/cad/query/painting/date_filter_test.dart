import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/date_filter.dart';

void main() {
  group('$CadRoute $DateRangeWidget Painting Test', () {
    testWidgets('expectNoOverflow ${DeviceDimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view
          .setLogicalSize(width: DeviceDimensions.galaxyFoldPortraitWidth);
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      tester.expectNoOverflow(of: dateFilterWidgetFinder);
    });
  });
}
