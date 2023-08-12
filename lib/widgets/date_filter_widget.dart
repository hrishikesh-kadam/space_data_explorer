import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../route/settings/bloc/settings_bloc.dart';
import '../route/settings/bloc/settings_state.dart';
import 'query_grid_container.dart';

typedef DateRangeSelected = void Function(DateTimeRange?);

enum DateFilter {
  min,
  max,
}

class DateFilterWidget extends StatefulWidget {
  DateFilterWidget({
    this.keyPrefix = '',
    required this.firstDate,
    required this.lastDate,
    this.onDateRangeSelected,
    required this.l10n,
    this.spacing = 8,
  }) : super(key: Key('$keyPrefix$defaultKey'));

  final String keyPrefix;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateRangeSelected? onDateRangeSelected;
  final AppLocalizations l10n;
  final double spacing;
  // ignore: unused_field
  final _log = Logger('$appNamePascalCase.DateFilterWidget');
  static const String defaultKey = 'date_filter_widget_key';
  static const String minDateKey = 'min_date_key';
  static const String maxDateKey = 'max_date_key';
  static const String selectDateRangeButtonKey = 'select_date_range_button_key';

  @override
  State<DateFilterWidget> createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  DateTimeRange? dateRange;

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: _getBody(context: context),
    );
  }

  Widget _getBody({
    required BuildContext context,
  }) {
    return Column(
      children: [
        Text(
          widget.l10n.dateFilter,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: widget.spacing),
        _getMinMaxWrap(context: context),
        SizedBox(height: widget.spacing),
        OutlinedButton(
          key: Key(
            '${widget.keyPrefix}'
            '${DateFilterWidget.selectDateRangeButtonKey}',
          ),
          onPressed: () {
            _dateRangePickerOnPressed(context: context);
          },
          child: Text(
            widget.l10n.selectDateRange,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    );
  }

  Widget _getMinMaxWrap({
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
              // TODO(hrishikesh-kadam): Merge this l10n with minimum, maximum
              widget.l10n.dateMin,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            FormattedDateRangeText(
              key: Key('${widget.keyPrefix}${DateFilterWidget.minDateKey}'),
              dateRange: dateRange,
              dateFilter: DateFilter.min,
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.l10n.dateMax,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8),
            FormattedDateRangeText(
              key: Key('${widget.keyPrefix}${DateFilterWidget.maxDateKey}'),
              dateRange: dateRange,
              dateFilter: DateFilter.max,
            ),
          ],
        ),
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
            case DateFilter.min:
              formattedDate = dateFormat.format(dateRange!.start);
              _log.fine('languageTag = $languageTag');
              _log.fine('dateFormat.pattern = ${dateFormat.pattern}');
            case DateFilter.max:
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
