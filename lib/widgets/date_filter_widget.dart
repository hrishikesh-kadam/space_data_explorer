import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

typedef DateTimeRangeCallback = void Function(DateTimeRange?);

enum DateFilter {
  dateMin,
  dateMax,
}

class DateFilterWidget extends StatefulWidget {
  const DateFilterWidget({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.onDateRangeSelected,
    required this.l10n,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTimeRangeCallback? onDateRangeSelected;
  final AppLocalizations l10n;

  @override
  State<DateFilterWidget> createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.l10n.dateFilters),
        Row(
          children: [
            Text(widget.l10n.dateMin),
            FormattedDateRangeText(
              dateRange: dateRange,
              dateFilter: DateFilter.dateMin,
            ),
            Text(widget.l10n.dateMax),
            FormattedDateRangeText(
              dateRange: dateRange,
              dateFilter: DateFilter.dateMax,
            ),
            OutlinedButton(
              onPressed: () {
                _dateRangePickerOnPressed(context: context);
              },
              child: Text(widget.l10n.selectDateRange),
            ),
          ],
        )
      ],
    );
  }

  void _dateRangePickerOnPressed({
    required BuildContext context,
  }) async {
    final dateRange = await showDateRangePicker(
      context: context,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    );
    setState(() {
      this.dateRange = dateRange;
    });
    if (widget.onDateRangeSelected != null) {
      widget.onDateRangeSelected!(dateRange);
    }
  }
}

class FormattedDateRangeText extends StatelessWidget {
  FormattedDateRangeText({
    super.key,
    this.dateRange,
    required this.dateFilter,
    this.notSelectedText = '-',
  });

  final DateTimeRange? dateRange;
  final DateFilter dateFilter;
  final String notSelectedText;
  final _log = Logger('$appNamePascalCase.FormattedDateRangeText');

  @override
  Widget build(BuildContext context) {
    String formattedDate;
    if (dateRange != null) {
      final locale = Localizations.localeOf(context).toLanguageTag();
      _log.debug(locale);
      final dateFormat = DateFormat.yMd(locale);
      switch (dateFilter) {
        case DateFilter.dateMin:
          formattedDate = dateFormat.format(dateRange!.start);
        case DateFilter.dateMax:
          formattedDate = dateFormat.format(dateRange!.end);
      }
    } else {
      formattedDate = notSelectedText;
    }
    return Text(formattedDate);
  }
}
