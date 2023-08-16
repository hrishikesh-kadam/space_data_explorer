import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../extension/common_finders.dart';
import '../../../globals.dart';

final dateFilterWidgetFinder = find.byKey(CadScreen.dateFilterWidgetKey);
final minDateFinder = find.byKey(const Key(
    '${CadScreen.dateFilterKeyPrefix}${DateFilterWidget.startDateKey}'));
final maxDateFinder = find.byKey(const Key(
    '${CadScreen.dateFilterKeyPrefix}${DateFilterWidget.endDateKey}'));
final selectDateRangeButtonFinder = find.byKey(const Key(
    '${CadScreen.dateFilterKeyPrefix}${DateFilterWidget.selectButtonKey}'));
const String notSelectedDefaultText =
    FormattedDateRangeText.notSelectedDefaultText;
final DateTime nowDate = DateTime.now();
final DateTime minDateForTest = nowDate.copyWith(day: 1);
final DateTime maxDateForTest = nowDate.copyWith(day: 2);

Future<void> selectDateRange(
  WidgetTester tester, {
  DateTimeRange? dateRange,
}) async {
  dateRange ??= DateTimeRange(start: minDateForTest, end: maxDateForTest);
  await tester.tap(selectDateRangeButtonFinder);
  await tester.pumpAndSettle();
  await tester.tap(find.text(dateRange.start.day.toString()).first);
  await tester.tap(find.text(dateRange.end.day.toString()).first);
  await tester.pumpAndSettle();
  await tester.tap(
    find.widgetWithText(TextButton, ml10n.saveButtonLabel),
    warnIfMissed: false,
  );
  await tester.pumpAndSettle();
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
    find.descendantTextContaining(of: dateFinder, pattern: actual),
    findsOneWidget,
  );
}
