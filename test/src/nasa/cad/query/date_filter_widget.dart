import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/widgets/date_filter_widget.dart';
import '../../../globals.dart';
import 'date_filter.dart';

final startLabelFinder = find.byKey(const Key(DateFilterWidget.startLabelKey));
final endLabelFinder = find.byKey(const Key(DateFilterWidget.endLabelKey));
final startDateFinder = find.byKey(const Key(DateFilterWidget.startDateKey));
final endDateFinder = find.byKey(const Key(DateFilterWidget.endDateKey));

final String title = l10n.dateFilter;
final String startTitle = '${l10n.minimum}:';
final String endTitle = '${l10n.maximum}:';
final DateTimeRange dateRange = DateTimeRange(
  start: minDateForTest,
  end: maxDateForTest,
);
final DateTime firstDate = DateTime(1900, 1, 1);
final DateTime lastDate = DateTime(2200, 12, 31);
final String selectButtonTitle = l10n.selectDateRange;
