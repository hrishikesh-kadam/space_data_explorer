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
  group('$CadRoute ${ChoiceChipQueryWidget<SmallBodyFilter>} Interaction Test',
      () {
    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(smallBodyFilterWidgetFinder, findsOneWidget);
      expectSmallBodyFilterSelected(
        tester,
        smallBodyFilter: SbdbCadQueryParameters.smallBodyFilterDefault,
      );
      expect(CadScreen.cadBloc!.state.smallBodyFilterState,
          const SmallBodyFilterState());
    });

    testWidgets('Select and unselect ${SmallBodyFilter.pha.name}',
        (tester) async {
      const smallBodyFilter = SmallBodyFilter.pha;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodyFilter(tester, smallBodyFilter: smallBodyFilter);
      expectSmallBodyFilterSelected(tester, smallBodyFilter: smallBodyFilter);
      expect(
        CadScreen.cadBloc!.state.smallBodyFilterState,
        const SmallBodyFilterState(smallBodyFilter: smallBodyFilter),
      );
      await tapSmallBodyFilter(tester, smallBodyFilter: smallBodyFilter);
      expectSmallBodyFilterSelected(
        tester,
        smallBodyFilter: SbdbCadQueryParameters.smallBodyFilterDefault,
      );
      expect(CadScreen.cadBloc!.state.smallBodyFilterState,
          const SmallBodyFilterState());
    });

    testWidgets('Select and search each', (tester) async {
      final List<SbdbCadQueryParameters> queryParamtersList = [
        const SbdbCadQueryParameters(),
        const SbdbCadQueryParameters(pha: true),
        const SbdbCadQueryParameters(nea: true),
        const SbdbCadQueryParameters(comet: true),
        const SbdbCadQueryParameters(neaComet: true),
      ];
      await pumpCadRouteAsInitialLocation(tester);
      for (var i = 0; i < CadScreen.smallBodyFilterSet.length; i++) {
        final smallBodyFilter = CadScreen.smallBodyFilterSet.elementAt(i);
        await tapSmallBodyFilter(tester, smallBodyFilter: smallBodyFilter);
        expectSmallBodyFilterSelected(tester, smallBodyFilter: smallBodyFilter);
        expect(
          CadScreen.cadBloc!.state.smallBodyFilterState,
          SmallBodyFilterState(smallBodyFilter: smallBodyFilter),
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
        CadScreen.cadBloc!.state.smallBodyFilterState,
        const SmallBodyFilterState(),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.enterText(textFieldFinder, designation);
      expectSmallBodyFilterSelected(
        tester,
        smallBodyFilter: SbdbCadQueryParameters.smallBodyFilterDefault,
      );
      expectChipsEnabled(tester, false);
      expect(
        CadScreen.cadBloc!.state.smallBodyFilterState,
        const SmallBodyFilterState(enabled: false),
      );
      await verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(des: designation),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodyFilterSelected(
        tester,
        smallBodyFilter: SbdbCadQueryParameters.smallBodyFilterDefault,
      );
      expectChipsEnabled(tester);
      expect(
        CadScreen.cadBloc!.state.smallBodyFilterState,
        const SmallBodyFilterState(),
      );
      await verifyQueryParameters(tester, const SbdbCadQueryParameters());
    });

    testWidgets(
        'Select ${SmallBodyFilter.pha.name}, '
        'select and unselect ${SmallBodySelector.designation.name}',
        (tester) async {
      const smallBodyFilter = SmallBodyFilter.pha;
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodyFilter(tester, smallBodyFilter: smallBodyFilter);
      expectChipsEnabled(tester);
      expect(
        CadScreen.cadBloc!.state.smallBodyFilterState,
        const SmallBodyFilterState(smallBodyFilter: smallBodyFilter),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.enterText(textFieldFinder, designation);
      expectSmallBodyFilterSelected(tester, smallBodyFilter: smallBodyFilter);
      expectChipsEnabled(tester, false);
      expect(
        CadScreen.cadBloc!.state.smallBodyFilterState,
        const SmallBodyFilterState(
            enabled: false, smallBodyFilter: smallBodyFilter),
      );
      await verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(des: designation),
      );
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodyFilterSelected(tester, smallBodyFilter: smallBodyFilter);
      expectChipsEnabled(tester);
      expect(
        CadScreen.cadBloc!.state.smallBodyFilterState,
        const SmallBodyFilterState(smallBodyFilter: smallBodyFilter),
      );
      await verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(pha: true),
      );
    });

    testWidgets('disableInputs', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      for (final smallBodyFilter in CadScreen.smallBodyFilterSet) {
        final chipFinder = smallBodyFilterChipFinderMap[smallBodyFilter]!;
        expect(chipFinder.hitTestable().evaluate().length, 1);
      }
      await emitDisableInputs(tester);
      for (final smallBodyFilter in CadScreen.smallBodyFilterSet) {
        final chipFinder = smallBodyFilterChipFinderMap[smallBodyFilter]!;
        expect(chipFinder.hitTestable().evaluate().length, 0);
      }
    });
  });
}
