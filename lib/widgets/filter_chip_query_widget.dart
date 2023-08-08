import 'package:flutter/material.dart';

import 'query_grid_container.dart';

typedef ChipsSelected<T> = void Function(Set<T> selected);

class FilterChipQueryWidget<T> extends StatelessWidget {
  FilterChipQueryWidget({
    this.keyPrefix = '',
    this.keys,
    required this.title,
    required this.values,
    required this.labels,
    this.selected = const {},
    this.spacing = 8,
    this.onChipsSelected,
  }) : super(key: Key('$keyPrefix$defaultKey'));

  final String keyPrefix;
  final Set<String>? keys;
  final String title;
  final Set<T> values;
  final Set<String> labels;
  final Set<T> selected;
  final double spacing;
  final ChipsSelected<T>? onChipsSelected;
  static const String defaultKey = 'filter_chip_query_widget_key';

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
              return FilterChip(
                key: keys != null
                    ? Key('$keyPrefix${keys!.elementAt(index)}')
                    : null,
                label: Text(
                  labels.elementAt(index),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                selected: selected.contains(values.elementAt(index)),
                onSelected: (selectedBool) {
                  if (onChipsSelected != null) {
                    final Set<T> newSelected = Set.from(selected);
                    if (selectedBool) {
                      newSelected.add(values.elementAt(index));
                    } else {
                      newSelected.remove(values.elementAt(index));
                    }
                    onChipsSelected!(newSelected);
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