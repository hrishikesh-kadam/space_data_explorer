import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helper/helper.dart';
import 'query_grid_container.dart';

typedef ValueChanged = void Function(String value, int index);
typedef UnitChanged<U> = void Function(U unit, int index);

class ValueRangeFilterWidget<U> extends StatelessWidget {
  const ValueRangeFilterWidget({
    super.key,
    this.keyPrefix = '',
    required this.title,
    required this.labels,
    this.defaultValues,
    this.values,
    this.keyboardTypes,
    this.inputFormattersList,
    this.textFieldTextAlign = TextAlign.center,
    this.textFieldWidth = 80,
    this.onValueChanged,
    this.units,
    this.unitSymbols,
    this.unitsSelected,
    this.onUnitChanged,
    this.spacing = 8,
  })  : assert(labels.length == 2),
        assert(defaultValues == null || defaultValues.length == 2),
        assert(values == null || values.length == 2),
        assert(defaultValues?.length == values?.length),
        assert(keyboardTypes == null || keyboardTypes.length == 2),
        assert(inputFormattersList == null || inputFormattersList.length == 2),
        assert(units?.length == unitSymbols?.length),
        assert(unitsSelected == null || unitsSelected.length == 2);

  final String keyPrefix;
  final String title;
  final Set<String> labels;
  final List<String?>? defaultValues;
  final List<String?>? values;
  final List<TextInputType?>? keyboardTypes;
  final List<List<TextInputFormatter>?>? inputFormattersList;
  final TextAlign textFieldTextAlign;
  final double textFieldWidth;
  final ValueChanged? onValueChanged;
  final Set<U>? units;
  final Set<String>? unitSymbols;
  final List<U>? unitsSelected;
  final UnitChanged<U>? onUnitChanged;
  final double spacing;
  static const String defaultKey = 'value_range_filter_widget_key';

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: _getBody(context: context),
    );
  }

  Widget _getBody({
    required BuildContext context,
  }) {
    double largestLabelWidth = getLargestTextWidth(
      context: context,
      textList: labels.toList(),
      style: Theme.of(context).textTheme.bodyMedium,
    );
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: spacing),
        _getValueWrap(
          context: context,
          index: 0,
          largestLabelWidth: largestLabelWidth,
        ),
        SizedBox(height: spacing),
        _getValueWrap(
          context: context,
          index: 1,
          largestLabelWidth: largestLabelWidth,
        ),
      ],
    );
  }

  Widget _getValueWrap({
    required BuildContext context,
    required int index,
    required double largestLabelWidth,
  }) {
    List<DropdownMenuItem<U>>? dropDownItems;
    if (units != null && units!.length > 1) {
      dropDownItems = [];
      for (int j = 0; j < units!.length; j++) {
        dropDownItems.add(DropdownMenuItem(
          value: units!.elementAt(j),
          child: Text(
            unitSymbols!.elementAt(j),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ));
      }
    }
    return Wrap(
      spacing: 16,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: largestLabelWidth,
          child: Text(
            labels.elementAt(index),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: textFieldWidth,
          child: TextField(
            controller:
                values != null && values![index] == defaultValues![index]
                    ? TextEditingController(text: defaultValues![index])
                    : null,
            keyboardType: keyboardTypes?[index],
            inputFormatters: inputFormattersList?[index],
            textAlign: textFieldTextAlign,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            onChanged: (value) {
              if (onValueChanged != null) {
                onValueChanged!(value, index);
              }
            },
          ),
        ),
        if (units != null && units!.length == 1)
          Text(
            unitSymbols!.first,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (units != null && units!.length > 1)
          DropdownButton(
            items: dropDownItems,
            value: unitsSelected?[index] ?? units!.first,
            onChanged: (unit) {
              if (onUnitChanged != null &&
                  // Not required, but just being extra safe here
                  unit != null) {
                onUnitChanged!(unit, index);
              }
            },
          ),
      ],
    );
  }
}
