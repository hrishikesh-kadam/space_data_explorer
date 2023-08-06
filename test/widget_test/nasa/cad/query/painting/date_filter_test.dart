import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../../../constants/dimensions.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/date_filter.dart';

void main() {
  group('$CadRoute $DateFilterWidget Painting Test', () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: Dimensions.galaxyFoldPortraitWidth);
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      tester.expectNotOverflowing(of: dateFilterWidgetFinder);
    });

    testWidgets('Doesn\'t Overflow 167', (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: 167);
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      tester.expectNotOverflowing(of: dateFilterWidgetFinder);
    });

    testWidgets('Doesn\'t Overflow 146', (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: 146);
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      tester.expectNotOverflowing(of: dateFilterWidgetFinder);
    });

    testWidgets('Does Overflow 145', (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: 145);
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      final overflowingRenderFlexList = tester.getOverflowingRenderFlexList(
        of: dateFilterWidgetFinder,
      );
      expect(overflowingRenderFlexList.length, greaterThan(0));
    });
  });
}
