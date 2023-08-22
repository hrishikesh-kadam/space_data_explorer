import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_query_widget.dart';
import '../../../../../constants/dimensions.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/small_body_filter.dart';

void main() {
  group('$CadRoute ${ChoiceChipQueryWidget<SmallBodyFilter>} Painting Test',
      () {
    testWidgets('Doesn\'t Overflow ${Dimensions.galaxyFoldPortraitWidth}',
        (WidgetTester tester) async {
      disableOverflowError();
      tester.view.setLogicalSize(
        width: Dimensions.galaxyFoldPortraitWidth,
        height: Dimensions.galaxyFoldPortraitHeight,
      );
      await pumpCadRouteAsInitialLocation(tester);
      await ensureFilterWidgetVisible(tester);
      for (final smallBodyFilter in CadScreen.smallBodySet) {
        await tapSmallBodyFilter(tester, smallBodyFilter: smallBodyFilter);
        tester.expectNoOverflow(of: smallBodyFilterWidgetFinder);
      }
    });
  });
}
