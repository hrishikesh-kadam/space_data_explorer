import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:mockito/mockito.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
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
        closeApproachBody: SbdbCadQueryParameters.defaultCloseApproachBody,
      );
      expect(
        CadScreen.cadBloc!.state.closeApproachBody,
        SbdbCadQueryParameters.defaultCloseApproachBody,
      );
    });

    testWidgets('Select and Unselect ${CloseApproachBody.moon.name}',
        (tester) async {
      const closeApproachBody = CloseApproachBody.moon;
      await pumpCadRouteAsInitialLocation(tester);
      await tapCloseApproachBody(tester, closeApproachBody: closeApproachBody);
      expectCloseApproachBodySelected(tester,
          closeApproachBody: closeApproachBody);
      expect(CadScreen.cadBloc!.state.closeApproachBody, closeApproachBody);
      await tapCloseApproachBody(tester, closeApproachBody: closeApproachBody);
      expectCloseApproachBodySelected(
        tester,
        closeApproachBody: SbdbCadQueryParameters.defaultCloseApproachBody,
      );
      expect(
        CadScreen.cadBloc!.state.closeApproachBody,
        SbdbCadQueryParameters.defaultCloseApproachBody,
      );
    });

    testWidgets('Select and Search Each', (tester) async {
      tester.view.setLogicalSize(height: 700);
      for (var i = 0; i < CadScreen.closeApproachBodySet.length; i++) {
        if (i == 0) {
          await pumpCadRouteAsInitialLocation(tester);
        }
        if (i > 0) {
          await tapBackButton(tester);
        }
        final closeApproachBody = CadScreen.closeApproachBodySet.elementAt(i);
        await tapCloseApproachBody(tester,
            closeApproachBody: closeApproachBody);
        expectCloseApproachBodySelected(tester,
            closeApproachBody: closeApproachBody);
        expect(CadScreen.cadBloc!.state.closeApproachBody, closeApproachBody);
        await tapSearchButton(tester);
        expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
        expect(find.byType(CadResultScreen), findsOneWidget);
        final sbdbCadApi = CadScreen.cadBloc!.sbdbCadApi;
        final verifyCloseApproachBody = switch (closeApproachBody) {
          SbdbCadQueryParameters.defaultCloseApproachBody => null,
          _ => closeApproachBody
        };
        verify(sbdbCadApi.get(
          queryParameters: SbdbCadQueryParameters(
            body: verifyCloseApproachBody,
          ).toJson(),
        )).called(1);
        clearInteractions(sbdbCadApi);
      }
    });
  });
}
