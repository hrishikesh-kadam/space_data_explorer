import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'filter_container.dart';

typedef ChipSelected<T> = void Function(T? value);

class ChoiceChipFilterWidget<T> extends StatefulWidget {
  ChoiceChipFilterWidget({
    this.keyPrefix = '',
    required this.title,
    required this.values,
    required this.labels,
    this.keys,
    this.selected,
    this.onChipSelected,
    required this.l10n,
    this.spacing = 8,
  }) : super(key: Key('$keyPrefix$defaultKey'));

  final String keyPrefix;
  final String title;
  final List<T> values;
  final List<String> labels;
  final List<String>? keys;
  final T? selected;
  final ChipSelected<T>? onChipSelected;
  final AppLocalizations l10n;
  final double spacing;
  static const String defaultKey = 'choice_chip_filter_widget_key';

  @override
  State<ChoiceChipFilterWidget<T>> createState() =>
      _ChoiceChipFilterWidgetState();
}

class _ChoiceChipFilterWidgetState<T> extends State<ChoiceChipFilterWidget<T>> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return QueryFilterContainer(
      child: _getBody(context: context),
    );
  }

  Widget _getBody({
    required BuildContext context,
  }) {
    if (widget.selected != null) {
      final index = widget.values.indexOf(widget.selected as T);
      selectedIndex = index >= 0 ? index : null;
    }
    return Column(
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: widget.spacing),
        Wrap(
          spacing: widget.spacing,
          runSpacing: widget.spacing,
          alignment: WrapAlignment.center,
          children: List<Widget>.generate(
            widget.labels.length,
            (index) {
              return ChoiceChip(
                key: widget.keys != null
                    ? Key('${widget.keyPrefix}${widget.keys![index]}')
                    : null,
                label: Text(
                  widget.labels[index],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                selected: selectedIndex == index,
                onSelected: (selected) {
                  setState(() {
                    selectedIndex = selected ? index : null;
                  });
                  if (widget.onChipSelected != null) {
                    final T? value = selected ? widget.values[index] : null;
                    widget.onChipSelected!(value);
                  }
                },
              );
            },
          ),
        )
      ],
    );
  }
}
