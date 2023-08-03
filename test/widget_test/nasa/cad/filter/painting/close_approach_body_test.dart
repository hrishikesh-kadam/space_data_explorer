import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_filter_widget.dart';
import '../../../../../constants/dimensions.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/filter/close_approach_body.dart';

void main() {
  group('$CadRoute ${ChoiceChipFilterWidget<CloseApproachBody>} Painting Test',
      () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setPhysicalSize(width: Dimensions.galaxyFoldPortraitWidth);
      await pumpCadRouteAsInitialLocation(tester);
      for (var i = 0; i < CadScreen.closeApproachBodyList.length; i++) {
        final closeApproachBody = CadScreen.closeApproachBodyList[i];
        await tapCloseApproachBody(tester,
            closeApproachBody: closeApproachBody);
        final overflowingRenderFlexList = tester.getOverflowingRenderFlexList(
          of: closeApproachBodyFilterWidgetFinder,
        );
        expect(overflowingRenderFlexList.length, 0);
      }
    });
  });
}
