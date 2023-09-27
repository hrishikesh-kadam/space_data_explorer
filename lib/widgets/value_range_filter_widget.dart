import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hrk_logging/hrk_logging.dart';

import '../globals.dart';
import '../helper/helper.dart';
import 'query_grid_container.dart';

typedef ValueParser<V> = V? Function(String text);
typedef ValueRangeChanged<V, U> = void Function(
  List<V?> valueList,
  List<String> textList,
  List<U>? unitList,
);

class ValueRangeFilterWidget<V, U> extends StatefulWidget {
  const ValueRangeFilterWidget({
    super.key,
    this.keyPrefix = '',
    this.title,
    required this.labels,
    required this.valueList,
    required this.textList,
    this.unitList,
    this.defaultValueList,
    this.defaultUnitList,
    required this.valueParser,
    this.keyboardType,
    this.inputFormatters,
    this.textFieldTextAlign = TextAlign.center,
    this.textFieldWidth = 80,
    this.units,
    this.unitSymbols,
    this.disableInputs = false,
    this.spacing = 8,
    this.onValueRangeChanged,
  })  : assert(labels.length == 2),
        assert(valueList.length == 2),
        assert(textList.length == 2),
        assert(unitList == null || unitList.length == 2),
        assert(defaultValueList == null || defaultValueList.length == 2),
        assert(defaultUnitList == null || defaultUnitList.length == 2),
        assert(units?.length == unitSymbols?.length);

  final String keyPrefix;
  final String? title;
  final Set<String> labels;
  final List<V?> valueList;
  final List<String> textList;
  final List<U>? unitList;
  final List<V?>? defaultValueList;
  final List<U?>? defaultUnitList;
  final ValueParser<V> valueParser;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textFieldTextAlign;
  final double textFieldWidth;
  final Set<U>? units;
  final Set<String>? unitSymbols;
  final bool disableInputs;
  final double spacing;
  final ValueRangeChanged<V, U>? onValueRangeChanged;
  static const String defaultKey = 'value_range_filter_widget_key';
  static const String valueTextFieldKeyPrefix = 'text_field_';
  static const String unitTextKeyPrefix = 'unit_text_';
  static const String unitDropdownItemKeyPrefix = 'unit_dropdown_item_';
  static const String unitDropdownKeyPrefix = 'unit_dropdown_';

  @override
  State<ValueRangeFilterWidget<V, U>> createState() =>
      _ValueRangeFilterWidgetState<V, U>();
}

enum StateMethod { initState, didUpdateWidget }

class _ValueRangeFilterWidgetState<V, U>
    extends State<ValueRangeFilterWidget<V, U>> {
  final List<V?> valueList = [];
  final List<String> textList = [];
  final List<U?> unitList = [];
  final List<V?> defaultValueList = [];
  final List<U?> defaultUnitList = [];
  final List<TextEditingController> textControllers = [];
  final List<FocusNode> textFocusNodes = [];
  final Logger logger = Logger('$appNamePascalCase.ValueRangeFilterWidget');

  @override
  void initState() {
    super.initState();
    initOrUpdate(method: StateMethod.initState);
  }

  @override
  void didUpdateWidget(covariant ValueRangeFilterWidget<V, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
    initOrUpdate(method: StateMethod.didUpdateWidget);
  }

  @override
  void dispose() {
    textControllers[0].dispose();
    textControllers[1].dispose();
    textFocusNodes[0].dispose();
    textFocusNodes[1].dispose();
    super.dispose();
  }

  void initOrUpdate({
    required StateMethod method,
  }) {
    valueList.clear();
    valueList.addAll(widget.valueList);
    textList.clear();
    textList.addAll(widget.textList);
    unitList.clear();
    unitList.addAll(widget.unitList ?? [null, null]);
    defaultValueList.clear();
    defaultValueList.addAll(widget.defaultValueList ?? [null, null]);
    defaultUnitList.clear();
    defaultUnitList.addAll(widget.defaultUnitList ?? [null, null]);
    if (method == StateMethod.initState) {
      textControllers.add(TextEditingController());
      textControllers.add(TextEditingController());
      textFocusNodes.add(FocusNode());
      textFocusNodes.add(FocusNode());
    }
  }

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: getBody(context: context),
    );
  }

  Widget getBody({
    required BuildContext context,
  }) {
    prepareState();
    double largestLabelWidth = getLargestTextWidth(
      context: context,
      textSet: widget.labels,
      style: Theme.of(context).textTheme.bodyMedium,
    );
    return Column(
      children: [
        if (widget.title != null)
          Text(
            widget.title!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        if (widget.title != null) SizedBox(height: widget.spacing),
        getLabelValueUnitWrap(
          context: context,
          index: 0,
          largestLabelWidth: largestLabelWidth,
        ),
        SizedBox(height: widget.spacing),
        getLabelValueUnitWrap(
          context: context,
          index: 1,
          largestLabelWidth: largestLabelWidth,
        ),
      ],
    );
  }

  void prepareState() {
    bool propogateState = false;
    for (int i = 0; i < 2; i++) {
      V? value = valueList[i];
      String text = textList[i];
      U? unit = unitList[i];
      final V? defaultValue = defaultValueList[i];
      final U? defaultUnit = defaultUnitList[i];
      // Still Editing, so ignore updates
      if (!textFocusNodes[i].hasFocus) {
        if (value == null && text.isEmpty && defaultValue != null) {
          value = defaultValue;
          unit = defaultUnit;
          valueList[i] = value;
          textList[i] = value.toString();
          unitList[i] = unit;
          propogateState = true;
        }
        // If in case of any mismatch between value and text, then fallback to
        // value
        if (value != widget.valueParser(text)) {
          text = value?.toString() ?? '';
          textList[i] = text;
          propogateState = true;
        }
        if (textControllers[i].text != text) {
          textControllers[i].text = text;
        }
      }
      if (unit == null && widget.units != null && widget.units!.isNotEmpty) {
        unit = widget.units!.first;
        unitList[i] = unit;
        propogateState = true;
      }
    }
    if (propogateState) {
      callOnValueRangeChanged();
    }
  }

  Widget getLabelValueUnitWrap({
    required BuildContext context,
    required int index,
    required double largestLabelWidth,
  }) {
    return Wrap(
      spacing: 16,
      runSpacing: widget.spacing,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        getLabelText(index: index, largestLabelWidth: largestLabelWidth),
        getValueTextField(index: index),
        if (widget.units?.isNotEmpty == true) getUnitWidget(index: index),
      ],
    );
  }

  Widget getLabelText({
    required int index,
    required double largestLabelWidth,
  }) {
    return SizedBox(
      width: largestLabelWidth,
      child: Text(
        widget.labels.elementAt(index),
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getValueTextField({
    required int index,
  }) {
    return SizedBox(
      width: widget.textFieldWidth,
      child: AbsorbPointer(
        absorbing: widget.disableInputs,
        child: TapRegion(
          onTapOutside: (event) {
            if (textFocusNodes[index].hasFocus) {
              if (textControllers[index].text.isEmpty &&
                  defaultValueList[index] != null) {
                setState(() {
                  valueList[index] = defaultValueList[index];
                  textList[index] = defaultValueList[index].toString();
                  unitList[index] = defaultUnitList[index];
                  // Required for Android, Chrome on Android
                  // Clicking on adjacent TextField, doesn't give hasFocus()
                  // value as false in prepareState()
                  textControllers[index].text = textList[index];
                });
                callOnValueRangeChanged();
              }
            }
          },
          child: TextField(
            key: Key(
              '${widget.keyPrefix}'
              '${ValueRangeFilterWidget.valueTextFieldKeyPrefix}'
              '${index}_key',
            ),
            controller: textControllers[index],
            focusNode: textFocusNodes[index],
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            textAlign: widget.textFieldTextAlign,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
            onTapOutside: (event) {
              if (textFocusNodes[index].hasFocus) {
                textFocusNodes[index].unfocus();
              }
            },
            onChanged: (text) {
              textList[index] = text;
              valueList[index] = widget.valueParser(text);
              callOnValueRangeChanged();
            },
          ),
        ),
      ),
    );
  }

  Widget getUnitWidget({
    required int index,
  }) {
    if (widget.units!.length < 2) {
      return Text(
        key: Key(
          '${widget.keyPrefix}'
          '${ValueRangeFilterWidget.unitTextKeyPrefix}'
          '${index}_key',
        ),
        widget.unitSymbols!.first,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else {
      final List<DropdownMenuItem<U>> dropDownItems = [];
      for (int j = 0; j < widget.units!.length; j++) {
        dropDownItems.add(DropdownMenuItem(
          key: Key(
            '${widget.keyPrefix}'
            '${ValueRangeFilterWidget.unitDropdownItemKeyPrefix}'
            '${index}_${widget.unitSymbols!.elementAt(j)}_key',
          ),
          value: widget.units!.elementAt(j),
          child: Text(
            widget.unitSymbols!.elementAt(j),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ));
      }
      return AbsorbPointer(
        absorbing: widget.disableInputs,
        child: DropdownButton<U>(
          key: Key(
            '${widget.keyPrefix}'
            '${ValueRangeFilterWidget.unitDropdownKeyPrefix}'
            '${index}_key',
          ),
          items: dropDownItems,
          value: unitList[index],
          onChanged: (unit) {
            assert(unit != null);
            unitList[index] = unit;
            callOnValueRangeChanged();
          },
        ),
      );
    }
  }

  void callOnValueRangeChanged() {
    if (widget.onValueRangeChanged != null) {
      List<V?> valueList = List.from(this.valueList);
      List<String> textList = List.from(this.textList);
      List<U>? unitList;
      if (this.unitList[0] != null && this.unitList[1] != null) {
        unitList = List.from(this.unitList);
      }
      widget.onValueRangeChanged!(
        valueList,
        textList,
        unitList,
      );
    }
  }
}
