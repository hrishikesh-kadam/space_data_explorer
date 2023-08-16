import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../helper/helper.dart';
import 'query_grid_container.dart';

typedef DateRangeSelected = void Function(DateTimeRange?);

enum DateFilter {
  start,
  end,
}

class DateFilterWidget extends StatelessWidget {
  DateFilterWidget({
    super.key,
    this.keyPrefix = '',
    required this.title,
    required this.startTitle,
    required this.endTitle,
    required this.dateRange,
    required this.firstDate,
    required this.lastDate,
    required this.dateFormat,
    this.notSelectedDateText = notSelectedDateDefaultText,
    required this.selectButtonTitle,
    required this.onDateRangeSelected,
    this.spacing = 8,
  });

  final String keyPrefix;
  final String title;
  final String startTitle;
  final String endTitle;
  final DateTimeRange? dateRange;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat dateFormat;
  final String notSelectedDateText;
  final String selectButtonTitle;
  final DateRangeSelected onDateRangeSelected;
  final double spacing;
  // ignore: unused_field
  final _log = Logger('$appNamePascalCase.DateFilterWidget');
  static const String defaultKey = 'date_filter_widget_key';
  static const String startDateKey = 'start_date_key';
  static const String endDateKey = 'end_date_key';
  static const String selectButtonKey = 'select_button_key';
  static const String notSelectedDateDefaultText = '-';

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: getBody(context: context),
    );
  }

  Widget getBody({
    required BuildContext context,
  }) {
    double largestLabelWidth = getLargestTextWidth(
      context: context,
      textSet: {startTitle, endTitle},
      style: Theme.of(context).textTheme.bodyMedium,
    );
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: spacing),
        getLabelDateWrap(
          context: context,
          filter: DateFilter.start,
          largestLabelWidth: largestLabelWidth,
        ),
        SizedBox(height: spacing),
        getLabelDateWrap(
          context: context,
          filter: DateFilter.end,
          largestLabelWidth: largestLabelWidth,
        ),
        SizedBox(height: spacing),
        OutlinedButton(
          key: Key('$keyPrefix$selectButtonKey'),
          onPressed: () {
            dateRangePickerOnPressed(context: context);
          },
          child: Text(
            selectButtonTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget getLabelDateWrap({
    required BuildContext context,
    required DateFilter filter,
    required double largestLabelWidth,
  }) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: largestLabelWidth,
          child: Text(
            filter == DateFilter.start ? startTitle : endTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        getFormattedDateText(context: context, filter: filter),
      ],
    );
  }

  Widget getFormattedDateText({
    required BuildContext context,
    required DateFilter filter,
  }) {
    final String dateKey = switch (filter) {
      DateFilter.start => startDateKey,
      DateFilter.end => endDateKey,
    };
    late final String formattedDate;
    if (dateRange != null) {
      formattedDate = switch (filter) {
        DateFilter.start => dateFormat.format(dateRange!.start),
        DateFilter.end => dateFormat.format(dateRange!.end),
      };
    } else {
      formattedDate = notSelectedDateText;
    }
    return Text(
      key: Key('$keyPrefix$dateKey'),
      formattedDate,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }

  void dateRangePickerOnPressed({
    required BuildContext context,
  }) async {
    final DateTimeRange? dateRange = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    onDateRangeSelected(dateRange);
  }
}
