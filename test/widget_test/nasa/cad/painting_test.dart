import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/constants/dimensions.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import '../../../src/nasa/cad/cad_route.dart';

void main() {
  group('$CadScreen Painting Test', () {
    group('Masonry', () {
      const double fitsThreeItems = 3 * Dimensions.cadQueryItemExtent +
          2 * Dimensions.pagePaddingHorizontal;
      const double fitsTwoItems = 2 * Dimensions.cadQueryItemExtent +
          2 * Dimensions.pagePaddingHorizontal;
      const double fitsOneItem =
          Dimensions.cadQueryItemExtent + 2 * Dimensions.pagePaddingHorizontal;

      testWidgets('Screen width ${fitsThreeItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems + 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 2);
      });

      testWidgets('Screen width $fitsThreeItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 2);
      });

      testWidgets('Screen width ${fitsThreeItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsThreeItems - 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 2);
      });

      testWidgets('Screen width ${fitsTwoItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems + 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 2);
      });

      testWidgets('Screen width $fitsTwoItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 2);
      });

      testWidgets('Screen width ${fitsTwoItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems - 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 1);
      });

      testWidgets('Screen width ${fitsOneItem + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem + 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 1);
      });

      testWidgets('Screen width $fitsOneItem', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 1);
      });

      testWidgets('Screen width ${fitsOneItem - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem - 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 1);
      });
    });
  });
}

void _expectCrossAxisCount(
  WidgetTester tester, {
  required int count,
}) {
  final gridItems = tester.widgetList(queryGridItemFinder).toList();
  final firstItemRect = tester.getRect(find.byWidget(gridItems[0]));
  final secondItemRect = tester.getRect(find.byWidget(gridItems[1]));
  final thirdItemRect = tester.getRect(find.byWidget(gridItems[2]));
  if (count == 2) {
    expect(firstItemRect.top == secondItemRect.top, true);
    expect(secondItemRect.top < thirdItemRect.top, true);
  } else if (count == 1) {
    expect(firstItemRect.top < secondItemRect.top, true);
    expect(secondItemRect.top < thirdItemRect.top, true);
  }
}
