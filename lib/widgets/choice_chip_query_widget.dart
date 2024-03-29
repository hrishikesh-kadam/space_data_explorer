import 'package:flutter/material.dart';

import 'query_grid_container.dart';

typedef ChipSelected<T> = void Function(T? value);

class ChoiceChipQueryWidget<T> extends StatelessWidget {
  const ChoiceChipQueryWidget({
    super.key,
    this.keyPrefix = '',
    this.enabled = true,
    this.title,
    required this.values,
    required this.labels,
    this.keys,
    this.selected,
    this.disableInputs = false,
    this.spacing = 8,
    this.onChipSelected,
  })  : assert(labels.length == values.length),
        assert(keys == null || keys.length == values.length);

  final String keyPrefix;
  final bool enabled;
  final String? title;
  final Set<T> values;
  final Set<String> labels;
  final Set<String>? keys;
  final T? selected;
  final bool disableInputs;
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
        if (title != null)
          Text(
            title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (title != null) SizedBox(height: spacing),
        _getChoiceChips(context)
      ],
    );
  }

  Wrap _getChoiceChips(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(
        values.length,
        (index) {
          return AbsorbPointer(
            absorbing: disableInputs,
            child: ChoiceChip(
              key: keys != null
                  ? Key('$keyPrefix${keys!.elementAt(index)}')
                  : null,
              label: Text(
                labels.elementAt(index),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              selected: selected == values.elementAt(index),
              onSelected: enabled
                  ? (selected) {
                      _onSelected(selected, index);
                    }
                  : null,
            ),
          );
        },
      ),
    );
  }

  void _onSelected(bool selected, int index) {
    if (onChipSelected != null) {
      final T? value = selected ? values.elementAt(index) : null;
      onChipSelected!(value);
    }
  }
}
