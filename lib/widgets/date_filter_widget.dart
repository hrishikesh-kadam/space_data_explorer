import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

typedef DateTimeRangeCallback = void Function(DateTimeRange?);

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
  String dateMin = notSelected;
  String dateMax = notSelected;
  static String notSelected = '-';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.l10n.dateFilters),
        Row(
          children: [
            Text(widget.l10n.dateMin),
            Text(dateMin),
            Text(widget.l10n.dateMax),
            Text(dateMax),
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
      if (dateRange != null) {
        final locale = Localizations.localeOf(context).toLanguageTag();
        dateMin = DateFormat.yMd(locale).format(dateRange.start);
        dateMax = DateFormat.yMd(locale).format(dateRange.end);
      } else {
        dateMin = dateMax = notSelected;
      }
    });
    if (widget.onDateRangeSelected != null) {
      widget.onDateRangeSelected!(dateRange);
    }
  }
}
