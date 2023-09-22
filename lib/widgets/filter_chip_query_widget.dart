import 'package:flutter/material.dart';

import 'query_grid_container.dart';

typedef ChipsSelected<T> = void Function(Set<T> selected);

class FilterChipQueryWidget<T> extends StatelessWidget {
  const FilterChipQueryWidget({
    super.key,
    this.keyPrefix = '',
    this.enabled = true,
    this.title,
    required this.values,
    required this.labels,
    this.keys,
    this.selected = const {},
    this.disableInputs = false,
    this.spacing = 8,
    this.onChipsSelected,
  })  : assert(labels.length == values.length),
        assert(keys == null || keys.length == values.length);

  final String keyPrefix;
  final bool enabled;
  final String? title;
  final Set<T> values;
  final Set<String> labels;
  final Set<String>? keys;
  final Set<T> selected;
  final bool disableInputs;
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
        if (title != null)
          Text(
            title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (title != null) SizedBox(height: spacing),
        _getFilterChips(context)
      ],
    );
  }

  Wrap _getFilterChips(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(
        values.length,
        (index) {
          return AbsorbPointer(
            absorbing: disableInputs,
            child: FilterChip(
              key: keys != null
                  ? Key('$keyPrefix${keys!.elementAt(index)}')
                  : null,
              label: Text(
                labels.elementAt(index),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              selected: selected.contains(values.elementAt(index)),
              onSelected: enabled
                  ? (selectedBool) {
                      _onSelected(selectedBool, index);
                    }
                  : null,
            ),
          );
        },
      ),
    );
  }

  void _onSelected(bool selectedBool, int index) {
    if (onChipsSelected != null) {
      final Set<T> newSelected = Set.from(selected);
      if (selectedBool) {
        newSelected.add(values.elementAt(index));
      } else {
        newSelected.remove(values.elementAt(index));
      }
      onChipsSelected!(newSelected);
    }
  }
}
