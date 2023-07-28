import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../../constants/dimensions.dart';
import '../../../../src/extension/widget_tester.dart';
import '../../../../src/helper/helper.dart';
import '../../../../src/nasa/cad/cad_route.dart';
import '../../../../src/nasa/cad/filter/date_filter_widget.dart';

void main() {
  group('$CadRoute $DateFilterWidget Painting Test', () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowException();
      tester.view.physicalSize = Size(
        Dimensions.galaxyFoldPortraitWidth,
        tester.view.physicalSize.height,
      );
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      final overflowingRenderFlexList = tester.getOverflowingRenderFlexList(
        of: dateFilterWidgetFinder,
      );
      expect(overflowingRenderFlexList.length, 0);
    });

    testWidgets('Doesn\'t Overflow 151', (WidgetTester tester) async {
      disableOverflowException();
      tester.view.physicalSize = Size(151, tester.view.physicalSize.height);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      final overflowingRenderFlexList = tester.getOverflowingRenderFlexList(
        of: dateFilterWidgetFinder,
      );
      expect(overflowingRenderFlexList.length, 0);
    });

    testWidgets('Does\'nt Overflow 140', (WidgetTester tester) async {
      disableOverflowException();
      tester.view.physicalSize = Size(140, tester.view.physicalSize.height);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      final overflowingRenderFlexList = tester.getOverflowingRenderFlexList(
        of: dateFilterWidgetFinder,
      );
      expect(overflowingRenderFlexList.length, 0);
    });

    testWidgets('Does Overflow 120', (WidgetTester tester) async {
      disableOverflowException();
      tester.view.physicalSize = Size(120, tester.view.physicalSize.height);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      final overflowingRenderFlexList = tester.getOverflowingRenderFlexList(
        of: dateFilterWidgetFinder,
      );
      expect(overflowingRenderFlexList.length, greaterThan(0));
    });
  });
}
