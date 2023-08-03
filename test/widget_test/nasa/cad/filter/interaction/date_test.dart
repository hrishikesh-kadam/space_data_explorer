import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/route/settings/date_format_pattern.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../../../src/globals.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/filter/date.dart';
import '../../../../../src/route/settings/settings_route.dart';
import '../../../../../src/route/settings/tiles/date_format_tile.dart';

void main() {
  group('$CadRoute $DateFilterWidget Interaction Test', () {
    testWidgets('DeferredLoading workaround', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tapSettingsButton(tester);
    });

    testWidgets('Basic', (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      expectDateText(notSelectedDefaultText, minDateFinder);
      expectDateText(notSelectedDefaultText, maxDateFinder);
    });

    testWidgets('Tap ${l10n.selectDateRange}, Select dates, Tap Save',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      expectDateTextContaining(startDate.day.toString(), minDateFinder);
      expectDateTextContaining(endDate.day.toString(), maxDateFinder);
    });

    testWidgets('Tap ${l10n.selectDateRange}, Tap $CloseButton',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tester.tap(selectDateRangeButtonFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CloseButton));
      await tester.pumpAndSettle();
      expectDateText(notSelectedDefaultText, minDateFinder);
      expectDateText(notSelectedDefaultText, maxDateFinder);
    });

    testWidgets(
        'Tap ${l10n.selectDateRange}, Select dates, Tap Save, '
        'Tap ${l10n.selectDateRange}, Tap $CloseButton',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      await tester.tap(selectDateRangeButtonFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CloseButton));
      await tester.pumpAndSettle();
      expectDateText(notSelectedDefaultText, minDateFinder);
      expectDateText(notSelectedDefaultText, maxDateFinder);
    });

    testWidgets('Reacts to $DateFormatPattern settings change',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      // Before
      Text minDateText = tester.widget<Text>(
          find.descendant(of: minDateFinder, matching: find.byType(Text)));
      Text maxDateText = tester.widget<Text>(
          find.descendant(of: maxDateFinder, matching: find.byType(Text)));
      String minDateBeforeString = minDateText.data!;
      String maxDateBeforeString = maxDateText.data!;
      // Change settings
      await tapSettingsButton(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: DateFormatPattern.ddMMyyyy);
      await tapBackButton(tester);
      // After
      minDateText = tester.widget<Text>(
          find.descendant(of: minDateFinder, matching: find.byType(Text)));
      maxDateText = tester.widget<Text>(
          find.descendant(of: maxDateFinder, matching: find.byType(Text)));
      String minDateAfterString = minDateText.data!;
      String maxDateAfterString = maxDateText.data!;
      expect(minDateAfterString != notSelectedDefaultText, isTrue);
      expect(maxDateAfterString != notSelectedDefaultText, isTrue);
      expect(minDateBeforeString != minDateAfterString, isTrue);
      expect(maxDateBeforeString != maxDateAfterString, isTrue);
    });
  });
}
