import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_query_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/small_body_filter.dart';
import '../../../../../src/nasa/cad/query/small_body_selector.dart';

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
        smallBody: SbdbCadQueryParameters.smallBodyDefault,
      );
      expect(CadScreen.cadBloc!.state.smallBodyState, const SmallBodyState());
    });

    testWidgets('Select and Unselect ${SmallBody.pha.name}', (tester) async {
      const smallBody = SmallBody.pha;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expect(
        CadScreen.cadBloc!.state.smallBodyState,
        const SmallBodyState(smallBody: smallBody),
      );
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(
        tester,
        smallBody: SbdbCadQueryParameters.smallBodyDefault,
      );
      expect(CadScreen.cadBloc!.state.smallBodyState, const SmallBodyState());
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
        expect(
          CadScreen.cadBloc!.state.smallBodyState,
          SmallBodyState(smallBody: smallBody),
        );
        await verifyQueryParameters(tester, queryParamtersList[i]);
      }
    });

    testWidgets('Select and unselect ${SmallBodySelector.designation.name}',
        (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      expectChipsEnabled(tester);
      expect(
        CadScreen.cadBloc!.state.smallBodyState,
        const SmallBodyState(),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.enterText(textFieldFinder, designation);
      expectSmallBodySelected(
        tester,
        smallBody: SbdbCadQueryParameters.smallBodyDefault,
      );
      expectChipsEnabled(tester, false);
      expect(
        CadScreen.cadBloc!.state.smallBodyState,
        const SmallBodyState(enabled: false),
      );
      await verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(des: designation),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelected(
        tester,
        smallBody: SbdbCadQueryParameters.smallBodyDefault,
      );
      expectChipsEnabled(tester);
      expect(
        CadScreen.cadBloc!.state.smallBodyState,
        const SmallBodyState(),
      );
      await verifyQueryParameters(tester, const SbdbCadQueryParameters());
    });

    testWidgets(
        'Select ${SmallBody.pha.name}, '
        'Select and unselect ${SmallBodySelector.designation.name}',
        (tester) async {
      const smallBody = SmallBody.pha;
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBody(tester, smallBody: smallBody);
      expectChipsEnabled(tester);
      expect(
        CadScreen.cadBloc!.state.smallBodyState,
        const SmallBodyState(smallBody: smallBody),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.enterText(textFieldFinder, designation);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expectChipsEnabled(tester, false);
      expect(
        CadScreen.cadBloc!.state.smallBodyState,
        const SmallBodyState(enabled: false, smallBody: smallBody),
      );
      await verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(des: designation),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expectChipsEnabled(tester);
      expect(
        CadScreen.cadBloc!.state.smallBodyState,
        const SmallBodyState(smallBody: smallBody),
      );
      await verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(pha: true),
      );
    });
  });
}
