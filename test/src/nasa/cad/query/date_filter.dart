import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../globals.dart';
import '../cad_route.dart';

final dateFilterWidgetFinder = find.byKey(CadScreen.dateFilterWidgetKey);
final minDateFinder = find.byKey(const Key(
    '${CadScreen.dateFilterKeyPrefix}${DateFilterWidget.startDateKey}'));
final maxDateFinder = find.byKey(const Key(
    '${CadScreen.dateFilterKeyPrefix}${DateFilterWidget.endDateKey}'));
final selectDateRangeButtonFinder = find.byKey(const Key(
    '${CadScreen.dateFilterKeyPrefix}${DateFilterWidget.selectButtonKey}'));
final DateTime minDateDefault = SbdbCadQueryParameters.dateMinDefault;
final DateTime maxDateDefault = SbdbCadQueryParameters.dateMaxDefault;
final String minDateTextDefault = l10n.nowToday;
final String maxDateTextDefault =
    l10n.plusSomeDays(CadScreen.dateMaxDaysDefault);
final DateTime minDateForTest = HrkDateTime.today().copyWith(day: 1);
final DateTime maxDateForTest = HrkDateTime.today().copyWith(day: 2);
final DateTimeRange dateRangeForTest = DateTimeRange(
  start: minDateForTest,
  end: maxDateForTest,
);

Future<void> selectDateRange(
  WidgetTester tester, {
  DateTimeRange? dateRange,
}) async {
  dateRange ??= dateRangeForTest;
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

void expectDate(WidgetTester tester, String expected, Finder finder) {
  expect(tester.widget<Text>(finder).data, expected);
}

void expectDatePattern(WidgetTester tester, Pattern pattern, Finder finder) {
  expect(tester.widget<Text>(finder).data?.contains(pattern), true);
}

Future<void> verifyDateRangeQueryParameters(
  WidgetTester tester,
  DateTimeRange dateRange,
) async {
  await verifyQueryParameters(
    tester,
    const SbdbCadQueryParameters().copyWithDateRange(
      dateRange.start,
      dateRange.end,
    ),
  );
}
