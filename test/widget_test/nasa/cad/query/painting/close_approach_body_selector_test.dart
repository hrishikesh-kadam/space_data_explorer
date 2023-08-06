import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_query_widget.dart';
import '../../../../../constants/dimensions.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/close_approach_body_selector.dart';

void main() {
  group('$CadRoute ${ChoiceChipQueryWidget<CloseApproachBody>} Painting Test',
      () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: Dimensions.galaxyFoldPortraitWidth);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.dragUntilVisible(
        closeApproachBodySelectorWidgetFinder,
        customScrollViewFinder,
        const Offset(0, -200),
      );
      await tester.pumpAndSettle();
      for (var i = 0; i < CadScreen.closeApproachBodySet.length; i++) {
        final closeApproachBody = CadScreen.closeApproachBodySet.elementAt(i);
        await tapCloseApproachBody(
          tester,
          closeApproachBody: closeApproachBody,
        );
        tester.expectNoOverflow(of: closeApproachBodySelectorWidgetFinder);
      }
    });
  });
}
