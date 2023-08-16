import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../route/settings/bloc/settings_bloc.dart';
import '../route/settings/bloc/settings_state.dart';
import 'query_grid_container.dart';

typedef DateRangeSelected = void Function(DateTimeRange?);

enum DateFilter {
  start,
  end,
}

class DateFilterWidget extends StatefulWidget {
  DateFilterWidget({
    super.key,
    this.keyPrefix = '',
    required this.title,
    required this.startTitle,
    required this.endTitle,
    required this.firstDate,
    required this.lastDate,
    required this.selectButtonTitle,
    this.onDateRangeSelected,
    this.spacing = 8,
  });

  final String keyPrefix;
  final String title;
  final String startTitle;
  final String endTitle;
  final DateTime firstDate;
  final DateTime lastDate;
  final String selectButtonTitle;
  final DateRangeSelected? onDateRangeSelected;
  final double spacing;
  // ignore: unused_field
  final _log = Logger('$appNamePascalCase.DateFilterWidget');
  static const String defaultKey = 'date_filter_widget_key';
  static const String startDateKey = 'start_date_key';
  static const String endDateKey = 'end_date_key';
  static const String selectButtonKey = 'select_button_key';

  @override
  State<DateFilterWidget> createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: getBody(context: context),
    );
  }

  Widget getBody({
    required BuildContext context,
  }) {
    return Column(
      children: [
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: widget.spacing),
        getStartEndWrap(context: context),
        SizedBox(height: widget.spacing),
        OutlinedButton(
          key: Key('${widget.keyPrefix}${DateFilterWidget.selectButtonKey}'),
          onPressed: () {
            dateRangePickerOnPressed(context: context);
          },
          child: Text(
            widget.selectButtonTitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  Widget getStartEndWrap({
    required BuildContext context,
  }) {
    return Wrap(
      spacing: 16,
      runSpacing: widget.spacing,
      alignment: WrapAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.startTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            FormattedDateRangeText(
              key: Key('${widget.keyPrefix}${DateFilterWidget.startDateKey}'),
              dateRange: dateRange,
              dateFilter: DateFilter.start,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.endTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            FormattedDateRangeText(
              key: Key('${widget.keyPrefix}${DateFilterWidget.endDateKey}'),
              dateRange: dateRange,
              dateFilter: DateFilter.end,
            ),
          ],
        ),
      ],
    );
  }

  void dateRangePickerOnPressed({
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
    this.notSelectedText = notSelectedDefaultText,
  });

  final DateTimeRange? dateRange;
  final DateFilter dateFilter;
  final String notSelectedText;
  final _log = Logger('$appNamePascalCase.FormattedDateRangeText');
  static const String notSelectedDefaultText = '-';

  @override
  Widget build(BuildContext context) {
    String formattedDate;
    if (dateRange != null) {
      return BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (previous, current) {
          return previous.dateFormatPattern != current.dateFormatPattern ||
              previous.language != current.language ||
              previous.systemLocales != current.systemLocales;
        },
        builder: (context, state) {
          final languageTag = Localizations.localeOf(context).toLanguageTag();
          final dateFormatPattern = state.dateFormatPattern;
          final dateFormat = DateFormat(dateFormatPattern.pattern, languageTag);
          switch (dateFilter) {
            case DateFilter.start:
              formattedDate = dateFormat.format(dateRange!.start);
              _log.fine('languageTag = $languageTag');
              _log.fine('dateFormat.pattern = ${dateFormat.pattern}');
            case DateFilter.end:
              formattedDate = dateFormat.format(dateRange!.end);
          }
          return Text(
            formattedDate,
            style: Theme.of(context).textTheme.bodyMedium,
          );
        },
      );
    } else {
      formattedDate = notSelectedText;
    }
    return Text(
      formattedDate,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
