import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_query_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/small_body_filter.dart';

void main() {
  group('$CadRoute ${ChoiceChipQueryWidget<SmallBody>} Interaction Test', () {
    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No Interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(smallBodyFilterWidgetFinder, findsOneWidget);
      expectSmallBodySelected(
        tester,
        smallBody: SbdbCadQueryParameters.defaultSmallBody,
      );
      expect(
        CadScreen.cadBloc!.state.smallBody,
        SbdbCadQueryParameters.defaultSmallBody,
      );
    });

    testWidgets('Select and Unselect ${SmallBody.pha.name}', (tester) async {
      const smallBody = SmallBody.pha;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expect(CadScreen.cadBloc!.state.smallBody, smallBody);
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(
        tester,
        smallBody: SbdbCadQueryParameters.defaultSmallBody,
      );
      expect(
        CadScreen.cadBloc!.state.smallBody,
        SbdbCadQueryParameters.defaultSmallBody,
      );
    });

    testWidgets('Select and Search Each', (tester) async {
      final List<SbdbCadQueryParameters> queryParamtersList = [
        const SbdbCadQueryParameters(),
        const SbdbCadQueryParameters(pha: true),
        const SbdbCadQueryParameters(nea: true),
        const SbdbCadQueryParameters(comet: true),
        const SbdbCadQueryParameters(neaComet: true),
      ];
      await pumpCadRouteAsInitialLocation(tester);
      for (var i = 0; i < CadScreen.smallBodySet.length; i++) {
        final smallBody = CadScreen.smallBodySet.elementAt(i);
        await tapSmallBody(tester, smallBody: smallBody);
        expectSmallBodySelected(tester, smallBody: smallBody);
        expect(CadScreen.cadBloc!.state.smallBody, smallBody);
        await verifyQueryParameters(tester, queryParamtersList[i]);
      }
    });
  });
}
