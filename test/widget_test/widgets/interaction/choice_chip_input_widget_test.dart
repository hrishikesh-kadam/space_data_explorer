import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/choice_chip_input_widget.dart';
import '../../../src/nasa/cad/cad_route.dart';
import '../../../src/nasa/cad/query/small_body_selector.dart';

void main() {
  group('${ChoiceChipInputWidget<SmallBodySelector>} Interaction Test', () {
    tearDown(() {
      KeyboardVisibilityTesting.setVisibilityForTesting(false);
    });

    testWidgets(
        'Select ${SmallBodySelector.spkId.name}, tap TextField, '
        'select ${SmallBodySelector.designation.name}', (tester) async {
      CadScreen.smallBodySelectorKeyboardTypes.clear();
      CadScreen.smallBodySelectorKeyboardTypes.add(TextInputType.text);
      CadScreen.smallBodySelectorKeyboardTypes.add(TextInputType.text);
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
  });
}
