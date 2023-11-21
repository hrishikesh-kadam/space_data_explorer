import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_input_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/small_body_selector.dart';

void main() {
  group(
      '$CadRoute ${ChoiceChipInputWidget<SmallBodySelector>} Interaction Test',
      () {
    tearDown(() {
      KeyboardVisibilityTesting.setVisibilityForTesting(false);
    });

    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(smallBodySelectorWidgetFinder, findsOneWidget);
      expectSmallBodySelectorSelected(tester, null);
      expect(tester.widget<TextField>(textFieldFinder).enabled, false);
      expectSmallBodySelectorState(const SmallBodySelectorState());
    });

    testWidgets('Select ${SmallBodySelector.spkId.name}', (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelectorSelected(tester, smallBodySelector);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
      verifyQueryParameters(tester, const SbdbCadQueryParameters());
    });

    testWidgets('Select ${SmallBodySelector.designation.name}', (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelectorSelected(tester, smallBodySelector);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
      verifyQueryParameters(tester, const SbdbCadQueryParameters());
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, '
        'select ${SmallBodySelector.designation.name}, '
        'select ${SmallBodySelector.spkId.name}, ', (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tapSmallBodySelector(tester, SmallBodySelector.designation);
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelectorSelected(tester, smallBodySelector);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
    });

    testWidgets('Select ${SmallBodySelector.spkId.name}, tap TextField',
        (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        true,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
    });

    testWidgets('Select ${SmallBodySelector.designation.name}, tap TextField',
        (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        true,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, '
        'select ${SmallBodySelector.designation.name}', (tester) async {
      SmallBodySelector smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      KeyboardVisibilityTesting.setVisibilityForTesting(true);
      smallBodySelector = SmallBodySelector.designation;
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        true,
      );
      expectSmallBodySelectorState(SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, tap outside',
        (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      // Required from flutter 3.17.0-0.0.pre beta
      await tester.pumpAndSettle();
      await tester.tap(titleFinder);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
    });

    testWidgets('Select and unselect ${SmallBodySelector.spkId.name}',
        (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelectorSelected(tester, smallBodySelector);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelectorSelected(tester, null);
      expect(tester.widget<TextField>(textFieldFinder).enabled, false);
      expectSmallBodySelectorState(const SmallBodySelectorState());
    });

    testWidgets('Select and unselect ${SmallBodySelector.designation.name}',
        (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelectorSelected(tester, smallBodySelector);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
      ));
      await tapSmallBodySelector(tester, smallBodySelector);
      expectSmallBodySelectorSelected(tester, null);
      expect(tester.widget<TextField>(textFieldFinder).enabled, false);
      expectSmallBodySelectorState(const SmallBodySelectorState());
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, '
        'input designation', (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, designation);
      final expectedSpkIdString = designation.replaceAll(RegExp(r'[^0-9]'), '');
      final expectedSpkId = expectedSpkIdString.isNotEmpty
          ? int.parse(expectedSpkIdString)
          : null;
      expectSmallBodySelectorState(SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        spkId: expectedSpkId,
      ));
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, input spkId',
        (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, spkId.toString());
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        spkId: spkId,
      ));
      verifyQueryParameters(tester, const SbdbCadQueryParameters(spk: spkId));
    });

    testWidgets(
        'Select ${SmallBodySelector.designation.name}, tap TextField, '
        'input spkId', (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, spkId.toString());
      expectSmallBodySelectorState(SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        designation: spkId.toString(),
      ));
    });

    testWidgets(
        'Select ${SmallBodySelector.designation.name}, tap TextField, '
        'input designation', (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, designation);
      expectSmallBodySelectorState(const SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        designation: designation,
      ));
      verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(des: designation),
      );
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, input spkId, '
        'select ${SmallBodySelector.designation.name}, input designation, '
        'select ${SmallBodySelector.spkId.name}, '
        'select ${SmallBodySelector.designation.name}', (tester) async {
      SmallBodySelector smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await ensureSelectorWidgetVisible(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, spkId.toString());
      expectSmallBodySelectorState(SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        spkId: spkId,
      ));
      smallBodySelector = SmallBodySelector.designation;
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.enterText(textFieldFinder, designation);
      expectSmallBodySelectorState(SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        spkId: spkId,
        designation: designation,
      ));
      smallBodySelector = SmallBodySelector.spkId;
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(
        tester.widget<TextField>(textFieldFinder).controller!.text,
        spkId.toString(),
      );
      expectSmallBodySelectorState(SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        spkId: spkId,
        designation: designation,
      ));
      smallBodySelector = SmallBodySelector.designation;
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(
        tester.widget<TextField>(textFieldFinder).controller!.text,
        designation,
      );
      expectSmallBodySelectorState(SmallBodySelectorState(
        smallBodySelector: smallBodySelector,
        spkId: spkId,
        designation: designation,
      ));
    });

    testWidgets('disableInputs', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      for (final smallBodySelector in CadScreen.smallBodySelectors) {
        final chipFinder = smallBodySelectorChipFinderMap[smallBodySelector]!;
        expect(chipFinder.hitTestable().evaluate().length, 1);
      }
      expect(textFieldFinder.hitTestable().evaluate().length, 1);
      await emitDisableInputs(tester);
      for (final smallBodySelector in CadScreen.smallBodySelectors) {
        final chipFinder = smallBodySelectorChipFinderMap[smallBodySelector]!;
        expect(chipFinder.hitTestable().evaluate().length, 0);
      }
      expect(textFieldFinder.hitTestable().evaluate().length, 0);
    });

    testWidgets('CadBloc prefilled, change, reset', (tester) async {
      SmallBodySelector smallBodySelector = SmallBodySelector.designation;
      final cadBloc = getCadBloc();
      cadBloc.add(CadSmallBodySelectorEvent(
        smallBodySelectorState: SmallBodySelectorState(
          smallBodySelector: smallBodySelector,
          designation: designation,
        ),
      ));
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      expectSmallBodySelectorSelected(tester, smallBodySelector);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(tester.widget<TextField>(textFieldFinder).controller!.text,
          designation);
      smallBodySelector = SmallBodySelector.spkId;
      cadBloc.add(CadSmallBodySelectorEvent(
        smallBodySelectorState: SmallBodySelectorState(
          smallBodySelector: smallBodySelector,
          spkId: spkId,
          designation: designation,
        ),
      ));
      await tester.pumpAndSettle();
      expectSmallBodySelectorSelected(tester, smallBodySelector);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).controller!.text,
        spkId.toString(),
      );
      cadBloc.add(const CadSmallBodySelectorEvent(
        smallBodySelectorState: SmallBodySelectorState(),
      ));
      await tester.pumpAndSettle();
      expectSmallBodySelectorSelected(tester, null);
      expect(tester.widget<TextField>(textFieldFinder).enabled, false);
      expect(tester.widget<TextField>(textFieldFinder).controller!.text, '');
    });
  });
}
