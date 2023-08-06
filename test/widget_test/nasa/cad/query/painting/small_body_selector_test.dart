import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/widgets/choice_chip_input_widget.dart';
import '../../../../../constants/dimensions.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/small_body_selector.dart';

void main() {
  group('$CadRoute ${ChoiceChipInputWidget<SmallBodySelector>} Painting Test',
      () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(width: Dimensions.galaxyFoldPortraitWidth);
      await pumpCadRouteAsInitialLocation(tester);
      await tester.dragUntilVisible(
        smallBodySelectorWidgetFinder,
        customScrollViewFinder,
        const Offset(0, -200),
      );
      await tester.pumpAndSettle();
      tester.expectNoOverflow(of: smallBodySelectorWidgetFinder);
      await tapSmallBodySelector(tester, SmallBodySelector.spkId);
      tester.expectNoOverflow(of: smallBodySelectorWidgetFinder);
      await tapSmallBodySelector(tester, SmallBodySelector.designation);
      tester.expectNoOverflow(of: smallBodySelectorWidgetFinder);
    });
  });
}
