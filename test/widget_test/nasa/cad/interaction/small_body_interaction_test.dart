import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/cad_result/cad_result_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_filter_widget.dart';
import '../../../../src/nasa/cad/cad_route.dart';
import '../../../../src/nasa/cad/filter/small_body_filter_widget.dart';

void main() {
  group('$CadRoute ${ChoiceChipFilterWidget<SmallBody>} Interaction Test', () {
    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tester.tap(find.byKey(CadScreen.searchButtonKey));
      await tester.pumpAndSettle();
    });

    testWidgets('Basic', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(smallBodyFilterWidgetFinder, findsOneWidget);
      expectSmallBodySelected(tester, smallBody: null);
      expect(CadScreen.cadBloc!.state.smallBody, null);
    });

    testWidgets('Select ${SmallBody.pha.displayName}', (tester) async {
      const smallBody = SmallBody.pha;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expect(CadScreen.cadBloc!.state.smallBody, smallBody);
    });

    testWidgets(
        'Select ${SmallBody.comet.displayName}, '
        'Select ${SmallBody.neaComet.displayName}', (tester) async {
      SmallBody smallBody = SmallBody.comet;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expect(CadScreen.cadBloc!.state.smallBody, smallBody);
      smallBody = SmallBody.neaComet;
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expect(CadScreen.cadBloc!.state.smallBody, smallBody);
    });

    testWidgets('Select and Unselect ${SmallBody.neo.displayName}',
        (tester) async {
      const smallBody = SmallBody.neo;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(tester, smallBody: smallBody);
      expect(CadScreen.cadBloc!.state.smallBody, smallBody);
      await tapSmallBody(tester, smallBody: smallBody);
      expectSmallBodySelected(tester, smallBody: null);
      expect(CadScreen.cadBloc!.state.smallBody, null);
    });

    testWidgets('Select and Search Each', (tester) async {
      for (var i = 0; i < CadScreen.smallBodyList.length; i++) {
        if (i == 0) {
          await pumpCadRouteAsInitialLocation(tester);
        }
        if (i > 0) {
          await tapBackButton(tester);
        }
        final smallBody = CadScreen.smallBodyList[i];
        await tapSmallBody(tester, smallBody: smallBody);
        await tester.tap(find.byKey(CadScreen.searchButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(CadScreen, skipOffstage: false), findsOneWidget);
        expect(find.byType(CadResultScreen), findsOneWidget);
      }
    });
  });
}
