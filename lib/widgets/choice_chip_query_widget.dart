import 'package:flutter/material.dart';

import 'query_grid_container.dart';

typedef ChipSelected<T> = void Function(T? value);

class ChoiceChipQueryWidget<T> extends StatelessWidget {
  ChoiceChipQueryWidget({
    this.keyPrefix = '',
    this.keys,
    required this.title,
    required this.values,
    required this.labels,
    this.selected,
    this.spacing = 8,
    this.onChipSelected,
  }) : super(key: Key('$keyPrefix$defaultKey'));

  final String keyPrefix;
  final Set<String>? keys;
  final String title;
  final Set<T> values;
  final Set<String> labels;
  final T? selected;
  final double spacing;
  final ChipSelected<T>? onChipSelected;
  static const String defaultKey = 'choice_chip_query_widget_key';

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
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: spacing),
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          children: List<Widget>.generate(
            values.length,
            (index) {
              return ChoiceChip(
                key: keys != null
                    ? Key('$keyPrefix${keys!.elementAt(index)}')
                    : null,
                label: Text(
                  labels.elementAt(index),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                selected: selected == values.elementAt(index),
                onSelected: (selected) {
                  if (onChipSelected != null) {
                    final T? value = selected ? values.elementAt(index) : null;
                    onChipSelected!(value);
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
