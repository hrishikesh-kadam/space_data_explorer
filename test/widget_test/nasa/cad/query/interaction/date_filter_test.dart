import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/route/settings/date_format_pattern.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../../../src/globals.dart';
import '../../../../../src/nasa/cad/cad_route.dart';
import '../../../../../src/nasa/cad/query/date_filter.dart';
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
      expectDate(tester, notSelectedDateText, minDateFinder);
      expectDate(tester, notSelectedDateText, maxDateFinder);
    });

    testWidgets('Tap ${l10n.selectDateRange}, Select dates, Tap Save',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      expectDatePattern(tester, minDateForTest.day.toString(), minDateFinder);
      expectDatePattern(tester, maxDateForTest.day.toString(), maxDateFinder);
    });

    testWidgets('Tap ${l10n.selectDateRange}, Tap $CloseButton',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await tester.tap(selectDateRangeButtonFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CloseButton));
      await tester.pumpAndSettle();
      expectDate(tester, notSelectedDateText, minDateFinder);
      expectDate(tester, notSelectedDateText, maxDateFinder);
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
      expectDate(tester, notSelectedDateText, minDateFinder);
      expectDate(tester, notSelectedDateText, maxDateFinder);
    });

    testWidgets('Reacts to $DateFormatPattern settings change',
        (WidgetTester tester) async {
      await pumpCadRouteAsInitialLocation(tester);
      await selectDateRange(tester);
      String minDateBeforeString = tester.widget<Text>(minDateFinder).data!;
      String maxDateBeforeString = tester.widget<Text>(maxDateFinder).data!;
      await tapSettingsButton(tester);
      await tapDateFormatTile(tester);
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: DateFormatPattern.ddMMyyyy);
      await tapBackButton(tester);
      String minDateAfterString = tester.widget<Text>(minDateFinder).data!;
      String maxDateAfterString = tester.widget<Text>(maxDateFinder).data!;
      expect(minDateAfterString != notSelectedDateText, true);
      expect(maxDateAfterString != notSelectedDateText, true);
      expect(minDateBeforeString != minDateAfterString, true);
      expect(maxDateBeforeString != maxDateAfterString, true);
    });
  });
}
