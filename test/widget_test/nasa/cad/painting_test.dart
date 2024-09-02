import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../../../src/helper/helper.dart';
import '../../../src/nasa/cad/cad_route.dart';

void main() {
  group('$CadScreen Painting Test', () {
    group('Masonry', () {
      const double fitsThreeItems = 3 * HrkDimensions.bodyItemBoxWidth +
          2 * HrkDimensions.pageMarginHorizontalHalf;
      const double fitsTwoItems = 2 * HrkDimensions.bodyItemBoxWidth +
          2 * HrkDimensions.pageMarginHorizontalHalf;
      const double fitsOneItem = HrkDimensions.bodyItemBoxWidth +
          2 * HrkDimensions.pageMarginHorizontalHalf;

      testWidgets('Screen width ${fitsThreeItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems + 1);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width $fitsThreeItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width ${fitsThreeItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems - 1);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width ${fitsTwoItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems + 1);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width $fitsTwoItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width ${fitsTwoItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems - 1);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width ${fitsOneItem + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem + 1, height: 800);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width $fitsOneItem', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem, height: 800);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: queryGridItemFinder);
      });

      testWidgets('Screen width ${fitsOneItem - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem - 1, height: 800);
        await pumpCadRouteAsInitialLocation(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: queryGridItemFinder);
      });
    });
  });
}
