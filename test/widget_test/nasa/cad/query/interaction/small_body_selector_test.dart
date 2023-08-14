import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_bloc.dart';
import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/widgets/choice_chip_input_widget.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/small_body_selector.dart';

void main() {
  group(
      '$CadRoute ${ChoiceChipInputWidget<SmallBodySelector>} Interaction Test',
      () {
    const String designation = '2023 HK';
    const int spkId = 54354503;

    tearDown(() {
      KeyboardVisibilityTesting.setVisibilityForTesting(false);
    });

    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSearchButton(tester);
    });

    testWidgets('No Interaction', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expect(smallBodySelectorWidgetFinder, findsOneWidget);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, false);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, false);
      expect(tester.widget<TextField>(textFieldFinder).enabled, false);
      expect(CadScreen.cadBloc!.state.smallBodySelector, null);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
    });

    testWidgets('Select ${SmallBodySelector.spkId.name}', (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, true);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, false);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
      verifyQueryParameters(tester, const SbdbCadQueryParameters());
    });

    testWidgets('Select ${SmallBodySelector.designation.name}', (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, false);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, true);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
      verifyQueryParameters(tester, const SbdbCadQueryParameters());
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, '
        'select ${SmallBodySelector.designation.name}, '
        'select ${SmallBodySelector.spkId.name}, ', (tester) async {
      SmallBodySelector smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tapSmallBodySelector(tester, SmallBodySelector.designation);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, true);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, false);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
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
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
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
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, '
        'select ${SmallBodySelector.designation.name}', (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, SmallBodySelector.spkId);
      await tester.tap(textFieldFinder);
      KeyboardVisibilityTesting.setVisibilityForTesting(true);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        true,
      );
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, tap outside',
        (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      await tester.tap(textFieldFinder);
      await tester.tap(titleFinder);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
    });

    testWidgets('Select and unselect ${SmallBodySelector.spkId.name}',
        (tester) async {
      const smallBodySelector = SmallBodySelector.spkId;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, true);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, false);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, false);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, false);
      expect(tester.widget<TextField>(textFieldFinder).enabled, false);
      expect(CadScreen.cadBloc!.state.smallBodySelector, null);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
    });

    testWidgets('Select and unselect ${SmallBodySelector.designation.name}',
        (tester) async {
      const smallBodySelector = SmallBodySelector.designation;
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, false);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, true);
      expect(tester.widget<TextField>(textFieldFinder).enabled, true);
      expect(
        tester.widget<TextField>(textFieldFinder).focusNode!.hasFocus,
        false,
      );
      expect(CadScreen.cadBloc!.state.smallBodySelector, smallBodySelector);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
      await tapSmallBodySelector(tester, smallBodySelector);
      expect(tester.widget<ChoiceChip>(spkIdChipFinder).selected, false);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, false);
      expect(tester.widget<TextField>(textFieldFinder).enabled, false);
      expect(CadScreen.cadBloc!.state.smallBodySelector, null);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, null);
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, '
        'input designation', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, SmallBodySelector.spkId);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, designation);
      final expectedSpkIdString = designation.replaceAll(RegExp(r'[^0-9]'), '');
      final expectedSpkId = expectedSpkIdString.isNotEmpty
          ? int.parse(expectedSpkIdString)
          : null;
      expect(CadScreen.cadBloc!.state.spkId, expectedSpkId);
      expect(CadScreen.cadBloc!.state.designation, null);
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, input spkId',
        (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, SmallBodySelector.spkId);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, spkId.toString());
      expect(CadScreen.cadBloc!.state.spkId, spkId);
      expect(CadScreen.cadBloc!.state.designation, null);
      verifyQueryParameters(tester, const SbdbCadQueryParameters(spk: spkId));
    });

    testWidgets(
        'Select ${SmallBodySelector.designation.name}, tap TextField, '
        'input spkId', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, SmallBodySelector.designation);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, spkId.toString());
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, spkId.toString());
    });

    testWidgets(
        'Select ${SmallBodySelector.designation.name}, tap TextField, '
        'input designation', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, SmallBodySelector.designation);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, designation);
      expect(CadScreen.cadBloc!.state.spkId, null);
      expect(CadScreen.cadBloc!.state.designation, designation);
      verifyQueryParameters(
        tester,
        const SbdbCadQueryParameters(des: designation),
      );
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, input spkId, '
        'Select ${SmallBodySelector.designation.name}, input designation, '
        'Select ${SmallBodySelector.spkId.name}, '
        'Select ${SmallBodySelector.designation.name}', (tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSmallBodySelector(tester, SmallBodySelector.spkId);
      await tester.tap(textFieldFinder);
      await tester.enterText(textFieldFinder, spkId.toString());
      expect(CadScreen.cadBloc!.state.spkId, spkId);
      expect(CadScreen.cadBloc!.state.designation, null);
      await tapSmallBodySelector(tester, SmallBodySelector.designation);
      await tester.enterText(textFieldFinder, designation);
      expect(CadScreen.cadBloc!.state.spkId, spkId);
      expect(CadScreen.cadBloc!.state.designation, designation);
      await tapSmallBodySelector(tester, SmallBodySelector.spkId);
      expect(
        tester.widget<TextField>(textFieldFinder).controller!.text,
        spkId.toString(),
      );
      expect(CadScreen.cadBloc!.state.spkId, spkId);
      expect(CadScreen.cadBloc!.state.designation, designation);
      await tapSmallBodySelector(tester, SmallBodySelector.designation);
      expect(
        tester.widget<TextField>(textFieldFinder).controller!.text,
        designation,
      );
      expect(CadScreen.cadBloc!.state.spkId, spkId);
      expect(CadScreen.cadBloc!.state.designation, designation);
    });

    testWidgets('CadBloc prefilled smallBodySelector', (tester) async {
      final cadBloc = getCadBloc();
      cadBloc.add(const CadSmallBodySelectorEvent(
        smallBodySelector: SmallBodySelector.designation,
      ));
      await pumpCadRouteAsInitialLocation(tester, cadBloc: cadBloc);
      expect(tester.widget<ChoiceChip>(designationChipFinder).selected, true);
    });
  });
}
