import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/route/settings/date_format_pattern.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../../src/extension/common_finders.dart';
import '../../../../src/globals.dart';
import '../../../../src/nasa/cad/cad_route.dart';
import '../../../../src/route/settings/settings_route.dart';
import '../../../route/settings/tiles/date_format_tile_test.dart';

void main() {
  group('$CadRoute $DateFilterWidget Interaction Test', () {
    final minDateFinder = find.byKey(CadScreen.minDateKey);
    final maxDateFinder = find.byKey(CadScreen.maxDateKey);
    final selectDateRangeButtonFinder =
        find.byKey(CadScreen.selectDateRangeButtonKey);
    const String notSelectedDefaultText =
        FormattedDateRangeText.notSelectedDefaultText;
    final DateTime nowDate = DateTime.now();
    final DateTime startDate = nowDate.copyWith(day: 1);
    final DateTime endDate = nowDate.copyWith(day: 2);

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
      await tester.tap(selectDateRangeButtonFinder);
      await tester.pumpAndSettle();
      expect(find.byType(DateRangePickerDialog), findsOneWidget);
      await tester.tap(find.text(startDate.day.toString()).first);
      await tester.tap(find.text(endDate.day.toString()).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Save'));
      await tester.pumpAndSettle();
      expect(find.byType(DateRangePickerDialog), findsNothing);
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
      await tester.tap(selectDateRangeButtonFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.text(startDate.day.toString()).first);
      await tester.tap(find.text(endDate.day.toString()).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Save'));
      await tester.pumpAndSettle();
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
      await tester.tap(selectDateRangeButtonFinder);
      await tester.pumpAndSettle();
      await tester.tap(find.text(startDate.day.toString()).first);
      await tester.tap(find.text(endDate.day.toString()).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Save'));
      await tester.pumpAndSettle();
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
      const dateFormatPattern = DateFormatPattern.ddMMyyyy;
      await chooseDateFormat(tester,
          l10n: l10n, dateFormatPattern: dateFormatPattern);
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

void expectDateText(
  String actual,
  Finder dateFinder,
) {
  expect(
    find.descendantText(of: dateFinder, text: actual),
    findsOneWidget,
  );
}

void expectDateTextContaining(
  Pattern actual,
  Finder dateFinder,
) {
  expect(
    find.descendantTexContaining(of: dateFinder, pattern: actual),
    findsOneWidget,
  );
}
