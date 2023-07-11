import 'package:flutter/material.dart';

import '../constants/localisation.dart';

typedef DateTimeRangeCallback = void Function(DateTimeRange?);

class DateFilterWidget extends StatefulWidget {
  const DateFilterWidget({
    super.key,
    required this.firstDate,
    required this.lastDate,
    this.onDateRangeSelected,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTimeRangeCallback? onDateRangeSelected;

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
        const Text(AppLocalisations.dateFilters),
        Row(
          children: [
            const Text(AppLocalisations.dateMin),
            Text(dateMin),
            const Text(AppLocalisations.dateMax),
            Text(dateMax),
            OutlinedButton(
              onPressed: () {
                _dateRangePickerOnPressed(context: context);
              },
              child: const Text(AppLocalisations.selectDateRange),
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
        dateMin = dateRange.start.toString();
        dateMax = dateRange.end.toString();
      } else {
        dateMin = dateMax = notSelected;
      }
    });
    if (widget.onDateRangeSelected != null) {
      widget.onDateRangeSelected!(dateRange);
    }
  }
}
