import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:intl/intl.dart';

import '../globals.dart';
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
    this.title,
    required this.startTitle,
    required this.endTitle,
    required this.dateRange,
    required this.firstDate,
    required this.lastDate,
    required this.dateFormat,
    this.startDateTextDefault = dateTextDefault,
    this.endDateTextDefault = dateTextDefault,
    required this.selectButtonTitle,
    this.disableInputs = false,
    this.spacing = 8,
    this.startEndAlign = false,
    required this.onDateRangeSelected,
  });

  final String keyPrefix;
  final String? title;
  final String startTitle;
  final String endTitle;
  final DateTimeRange? dateRange;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateFormat dateFormat;
  final String startDateTextDefault;
  final String endDateTextDefault;
  final String selectButtonTitle;
  final bool disableInputs;
  final double spacing;
  final bool startEndAlign;
  final DateRangeSelected onDateRangeSelected;
  // ignore: unused_field
  final _logger = Logger('$appNamePascalCase.DateFilterWidget');
  static const String defaultKey = 'date_filter_widget_key';
  static const String startLabelKey = 'start_label_key';
  static const String endLabelKey = 'end_label_key';
  static const String startDateKey = 'start_date_key';
  static const String endDateKey = 'end_date_key';
  static const String selectButtonKey = 'select_button_key';
  static const String dateTextDefault = '-';

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: getBody(context: context),
    );
  }

  Widget getBody({
    required BuildContext context,
  }) {
    final ThemeData themeData = Theme.of(context);
    List<String> formattedDateStringList = getFormattedDateStringList();
    double? largestTextWidth = startEndAlign
        ? getLargestTextWidth(
            context: context,
            textSet: {
              startTitle,
              endTitle,
              ...formattedDateStringList.toSet(),
            },
            style: themeData.textTheme.bodyMedium,
          )
        : null;
    return Column(
      children: [
        if (title != null)
          Text(
            title!,
            textAlign: TextAlign.center,
            style: themeData.textTheme.titleMedium,
          ),
        if (title != null) SizedBox(height: spacing),
        getLabelDateWrap(
          context: context,
          filter: DateFilter.start,
          largestTextWidth: largestTextWidth,
          formattedDateString: formattedDateStringList[0],
        ),
        SizedBox(height: spacing),
        getLabelDateWrap(
          context: context,
          filter: DateFilter.end,
          largestTextWidth: largestTextWidth,
          formattedDateString: formattedDateStringList[1],
        ),
        SizedBox(height: spacing),
        AbsorbPointer(
          absorbing: disableInputs,
          child: FilledButton.tonal(
            key: Key('$keyPrefix$selectButtonKey'),
            onPressed: () {
              dateRangePickerOnPressed(context: context);
            },
            child: Text(
              selectButtonTitle,
              style: themeData.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  Widget getLabelDateWrap({
    required BuildContext context,
    required DateFilter filter,
    required double? largestTextWidth,
    required String formattedDateString,
  }) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: largestTextWidth,
          child: Text(
            key: filter == DateFilter.start
                ? Key('$keyPrefix$startLabelKey')
                : Key('$keyPrefix$endLabelKey'),
            filter == DateFilter.start ? startTitle : endTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: startEndAlign ? TextAlign.end : null,
          ),
        ),
        SizedBox(
          width: largestTextWidth,
          child: Text(
            key: filter == DateFilter.start
                ? Key('$keyPrefix$startDateKey')
                : Key('$keyPrefix$endDateKey'),
            formattedDateString,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: startEndAlign ? TextAlign.start : null,
          ),
        ),
      ],
    );
  }

  List<String> getFormattedDateStringList() {
    final List<String> formattedDateSet = [];
    if (dateRange != null) {
      formattedDateSet.add(dateFormat.format(dateRange!.start));
      formattedDateSet.add(dateFormat.format(dateRange!.end));
    } else {
      formattedDateSet.add(startDateTextDefault);
      formattedDateSet.add(endDateTextDefault);
    }
    return formattedDateSet;
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
