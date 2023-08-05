import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/constants/dimensions.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/widgets/query_grid_container.dart';
import '../../../../../src/nasa/cad/cad_route.dart';

void main() {
  group('$CadRoute Filter Painting Test', () {
    group('Masonry', () {
      const fitsTwoItems = 2 * Dimensions.cadQueryItemExtent +
          2 * Dimensions.pagePaddingHorizontal;
      const fitsOneItem =
          Dimensions.cadQueryItemExtent + 2 * Dimensions.pagePaddingHorizontal;

      testWidgets('Screen Width ${fitsTwoItems + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems + 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 2);
      });

      testWidgets('Screen Width $fitsTwoItems', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 2);
      });

      testWidgets('Screen Width ${fitsTwoItems - 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsTwoItems - 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 1);
      });

      testWidgets('Screen Width ${fitsOneItem + 1}',
          (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem + 1);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 1);
      });

      testWidgets('Screen Width $fitsOneItem', (WidgetTester tester) async {
        tester.view.setLogicalSize(width: fitsOneItem);
        await pumpCadRouteAsInitialLocation(tester);
        _expectCrossAxisCount(tester, count: 1);
      });

      testWidgets('Screen Width ${fitsOneItem - 1}',
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
  final queryGridItems =
      tester.widgetList<QueryItemContainer>(queryGridItemFinder).toList();
  final firstItemRect = tester.getRect(find.byWidget(queryGridItems[0]));
  final secondItemRect = tester.getRect(find.byWidget(queryGridItems[1]));
  final thirdItemRect = tester.getRect(find.byWidget(queryGridItems[2]));
  if (count == 2) {
    expect(firstItemRect.top == secondItemRect.top, true);
    expect(secondItemRect.top < thirdItemRect.top, true);
  } else if (count == 1) {
    expect(firstItemRect.top < secondItemRect.top, true);
    expect(secondItemRect.top < thirdItemRect.top, true);
  }
}
