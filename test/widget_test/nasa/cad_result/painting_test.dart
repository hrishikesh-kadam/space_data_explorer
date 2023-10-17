import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:hrk_nasa_apis_test/hrk_nasa_apis_test.dart';

import 'package:space_data_explorer/constants/dimensions.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import '../../../constants/dimensions.dart';
import '../../../src/helper/helper.dart';
import '../../../src/nasa/cad_result/cad_result_route.dart';

void main() {
  group('$CadResultScreen Painting Test', () {
    final JsonMap $extra = {
      '$SbdbCadBody': SbdbCadBodyExt.getSample('200/1'),
    };

    testWidgets('Doesn\'t Overflow ${TestDimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: TestDimensions.galaxyFoldPortraitWidth);
      await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
      tester.expectNoOverflow(of: getResultGridItemFinder(0));
    });

    group('Masonry', () {
      const double fitsThreeItems = 3 * Dimensions.cadQueryItemBoxWidth +
          2 * Dimensions.pageMarginHorizontalHalf;
      const double fitsTwoItems = 2 * Dimensions.cadQueryItemBoxWidth +
          2 * Dimensions.pageMarginHorizontalHalf;
      const double fitsOneItem = Dimensions.cadQueryItemBoxWidth +
          2 * Dimensions.pageMarginHorizontalHalf;
      const double fitsThreeItemsVertically = 1200;

      testWidgets('Screen width ${fitsThreeItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsThreeItems + 1,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 2,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width $fitsThreeItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsThreeItems,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 2,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width ${fitsThreeItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsThreeItems - 1,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 2,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width ${fitsTwoItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsTwoItems + 1,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 2,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width $fitsTwoItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsTwoItems,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 2,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width ${fitsTwoItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsTwoItems - 1,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 1,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width ${fitsOneItem + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsOneItem + 1,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 1,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width $fitsOneItem', (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsOneItem,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 1,
          itemFinder: resultGridItemsFinder,
        );
      });

      testWidgets('Screen width ${fitsOneItem - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(
          width: fitsOneItem - 1,
          height: fitsThreeItemsVertically,
        );
        await pumpCadResultRouteAsInitialLocation(tester, $extra: $extra);
        expectCrossAxisCount(
          tester,
          count: 1,
          itemFinder: resultGridItemsFinder,
        );
      });
    });
  });
}
