import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/constants/dimensions.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../src/helper/helper.dart';
import '../../../src/route/home/home_route.dart';

void main() {
  group('$HomeScreen Painting Test', () {
    group('Masonry', () {
      const double fitsThreeItems = 3 * Dimensions.orgItemBoxWidth +
          2 * Dimensions.pageMarginHorizontalHalf;
      const double fitsTwoItems = 2 * Dimensions.orgItemBoxWidth +
          2 * Dimensions.pageMarginHorizontalHalf;
      const double fitsOneItem =
          Dimensions.orgItemBoxWidth + 2 * Dimensions.pageMarginHorizontalHalf;

      testWidgets('Screen width ${fitsThreeItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems + 1);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width $fitsThreeItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width ${fitsThreeItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems - 1);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width ${fitsTwoItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems + 1);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width $fitsTwoItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 2, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width ${fitsTwoItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems - 1);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width ${fitsOneItem + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem + 1);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width $fitsOneItem', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: orgItemFinder);
      });

      testWidgets('Screen width ${fitsOneItem - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem - 1);
        await pumpHomeRoute(tester);
        expectCrossAxisCount(tester, count: 1, itemFinder: orgItemFinder);
      });
    });
  });
}
