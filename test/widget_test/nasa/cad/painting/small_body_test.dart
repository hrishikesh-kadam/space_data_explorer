import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_filter_widget.dart';
import '../../../../constants/dimensions.dart';
import '../../../../src/nasa/cad/cad_route.dart';
import '../../../../src/nasa/cad/filter/small_body_filter_widget.dart';

void main() {
  group('$CadRoute ${ChoiceChipFilterWidget<SmallBody>} Painting Test', () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.physicalSize = Size(
        Dimensions.galaxyFoldPortraitWidth,
        tester.view.physicalSize.height,
      );
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() => tester.view.resetPhysicalSize());
      addTearDown(() => tester.view.resetDevicePixelRatio());
      await pumpCadRouteAsInitialLocation(tester);
      for (var i = 0; i < CadScreen.smallBodyList.length; i++) {
        final smallBody = CadScreen.smallBodyList[i];
        await tapSmallBody(tester, smallBody: smallBody);
        final overflowingRenderFlexList = tester.getOverflowingRenderFlexList(
          of: smallBodyFilterWidgetFinder,
        );
        expect(overflowingRenderFlexList.length, 0);
      }
    });
  });
}
