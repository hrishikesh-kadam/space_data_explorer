import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_query_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/close_approach_body_selector.dart';

void main() {
  group(
      '$CadRoute ${ChoiceChipQueryWidget<CloseApproachBody>} Interaction Test',
      () {
    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No Interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(closeApproachBodySelectorWidgetFinder, findsOneWidget);
      expectCloseApproachBodySelected(
        tester,
        closeApproachBody: SbdbCadQueryParameters.closeApproachBodyDefault,
      );
      expect(
        CadScreen.cadBloc!.state.closeApproachBody,
        SbdbCadQueryParameters.closeApproachBodyDefault,
      );
    });

    testWidgets('Select and Unselect ${CloseApproachBody.moon.name}',
        (tester) async {
      const closeApproachBody = CloseApproachBody.moon;
      await pumpCadRouteAsInitialLocation(tester);
      await ensureSelectorWidgetVisible(tester);
      await tapCloseApproachBody(tester, closeApproachBody: closeApproachBody);
      expectCloseApproachBodySelected(tester,
          closeApproachBody: closeApproachBody);
      expect(CadScreen.cadBloc!.state.closeApproachBody, closeApproachBody);
      await tapCloseApproachBody(tester, closeApproachBody: closeApproachBody);
      expectCloseApproachBodySelected(
        tester,
        closeApproachBody: SbdbCadQueryParameters.closeApproachBodyDefault,
      );
      expect(
        CadScreen.cadBloc!.state.closeApproachBody,
        SbdbCadQueryParameters.closeApproachBodyDefault,
      );
    });

    testWidgets('Select and Search Each', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      for (var i = 0; i < CadScreen.closeApproachBodySet.length; i++) {
        await ensureSelectorWidgetVisible(tester);
        final closeApproachBody = CadScreen.closeApproachBodySet.elementAt(i);
        await tapCloseApproachBody(tester,
            closeApproachBody: closeApproachBody);
        expectCloseApproachBodySelected(tester,
            closeApproachBody: closeApproachBody);
        expect(CadScreen.cadBloc!.state.closeApproachBody, closeApproachBody);
        final verifyCloseApproachBody = switch (closeApproachBody) {
          SbdbCadQueryParameters.closeApproachBodyDefault => null,
          _ => closeApproachBody
        };
        await verifyCloseApproachBodyQueryParameters(
          tester,
          verifyCloseApproachBody,
        );
      }
    });
  });
}
