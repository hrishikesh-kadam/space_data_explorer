import 'package:flutter/material.dart';

import 'query_grid_container.dart';

typedef ChipSelected<T> = void Function(T? value);

class ChoiceChipQueryWidget<T> extends StatefulWidget {
  ChoiceChipQueryWidget({
    this.keyPrefix = '',
    required this.title,
    required this.values,
    required this.labels,
    this.keys,
    this.selected,
    this.spacing = 8,
    this.onChipSelected,
  }) : super(key: Key('$keyPrefix$defaultKey'));

  final String keyPrefix;
  final String title;
  final List<T> values;
  final List<String> labels;
  final List<String>? keys;
  final T? selected;
  final double spacing;
  final ChipSelected<T>? onChipSelected;
  static const String defaultKey = 'choice_chip_query_widget_key';

  @override
  State<ChoiceChipQueryWidget<T>> createState() =>
      _ChoiceChipQueryWidgetState();
}

class _ChoiceChipQueryWidgetState<T> extends State<ChoiceChipQueryWidget<T>> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
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
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: widget.spacing),
        Wrap(
          spacing: widget.spacing,
          runSpacing: widget.spacing,
          alignment: WrapAlignment.center,
          children: List<Widget>.generate(
            widget.values.length,
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
