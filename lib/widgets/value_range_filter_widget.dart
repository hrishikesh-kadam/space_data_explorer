import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../globals.dart';
import '../helper/helper.dart';
import 'query_grid_container.dart';

typedef ValueParser<V> = V? Function(String text);
typedef ValueRangeChanged<V, U extends Unit> = void Function(
  ValueRange<V, U> range,
  ValueRange<String, Never> rangeText,
);

class ValueRangeFilterWidget<V, U extends Unit> extends StatefulWidget {
  const ValueRangeFilterWidget({
    super.key,
    this.keyPrefix = '',
    required this.title,
    required this.labels,
    required this.range,
    required this.rangeText,
    this.defaultRange,
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
        assert(units?.length == unitSymbols?.length);

  final String keyPrefix;
  final String title;
  final Set<String> labels;
  final ValueRange<V, U> range;
  final ValueRange<String, Never> rangeText;
  final ValueRange<V, U>? defaultRange;
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

  @override
  State<ValueRangeFilterWidget<V, U>> createState() =>
      _ValueRangeFilterWidgetState<V, U>();
}

enum StateMethod { initState, didUpdateWidget }

class _ValueRangeFilterWidgetState<V, U extends Unit>
    extends State<ValueRangeFilterWidget<V, U>> {
  final List<ValueUnit<V, U>> rangeList = [];
  final List<ValueUnit<String, Never>> rangeTextList = [];
  final List<ValueUnit<V, U>?> defaultRangeList = [];
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
    rangeList.clear();
    assert(widget.range.start != null);
    rangeList.add(widget.range.start!);
    assert(widget.range.end != null);
    rangeList.add(widget.range.end!);
    rangeTextList.clear();
    assert(widget.rangeText.start != null);
    rangeTextList.add(widget.rangeText.start!);
    assert(widget.rangeText.end != null);
    rangeTextList.add(widget.rangeText.end!);
    defaultRangeList.clear();
    defaultRangeList.add(widget.defaultRange?.start);
    defaultRangeList.add(widget.defaultRange?.end);
    if (method == StateMethod.initState) {
      textControllers
        ..add(TextEditingController())
        ..add(TextEditingController());
      textFocusNodes
        ..add(FocusNode())
        ..add(FocusNode());
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
        Text(
          widget.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: widget.spacing),
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
      V? value = rangeList[i].value;
      U? unit = rangeList[i].unit;
      String text = rangeTextList[i].value ?? '';
      final V? defaultValue = defaultRangeList[i]?.value;
      final U? defaultUnit = defaultRangeList[i]?.unit;
      // Still Editing, so ignore updates
      if (!textFocusNodes[i].hasFocus) {
        if (value == null && text.isEmpty && defaultValue != null) {
          value = defaultValue;
          unit = defaultUnit;
          rangeList[i] = ValueUnit<V, U>(value: value, unit: unit);
          rangeTextList[i] = ValueUnit(value: defaultValue.toString());
          propogateState = true;
        }
        // If in case of any mismatch between value and text, then fallback to
        // value
        if (value != widget.valueParser(text)) {
          text = value?.toString() ?? '';
          rangeTextList[i] = ValueUnit(value: text);
          propogateState = true;
        }
        if (textControllers[i].text != text) {
          textControllers[i].text = text;
        }
      }
      if (unit == null && widget.units?.isNotEmpty != null) {
        unit = widget.units!.first;
        rangeList[i] = rangeList[i].copyWith(unit: unit);
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
                  defaultRangeList[index]?.value != null) {
                setState(() {
                  rangeList[index] = defaultRangeList[index]!;
                  rangeTextList[index] = ValueUnit(
                    value: defaultRangeList[index]!.value!.toString(),
                  );
                  // Required for Android, Chrome on Android
                  // Clicking on adjacent TextField, doesn't give hasFocus()
                  // value as false in prepareState()
                  textControllers[index].text = rangeTextList[index].value!;
                });
                callOnValueRangeChanged();
              }
            }
          },
          child: TextField(
            key: Key('${widget.keyPrefix}text_field_$index'),
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
              rangeTextList[index] = ValueUnit(value: text);
              V? value = widget.valueParser(text);
              rangeList[index] = rangeList[index].copyWith(value: value);
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
        key: Key('${widget.keyPrefix}unit_text_$index'),
        widget.unitSymbols!.first,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else {
      final List<DropdownMenuItem<U>> dropDownItems = [];
      for (int j = 0; j < widget.units!.length; j++) {
        dropDownItems.add(DropdownMenuItem(
          key: Key(
            '${widget.keyPrefix}'
            'unit_dropdown_item_${index}_${widget.unitSymbols!.elementAt(j)}',
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
          key: Key('${widget.keyPrefix}unit_dropdown_$index'),
          items: dropDownItems,
          value: rangeList[index].unit,
          onChanged: (unit) {
            assert(unit != null);
            rangeList[index] = rangeList[index].copyWith(unit: unit);
            callOnValueRangeChanged();
          },
        ),
      );
    }
  }

  void callOnValueRangeChanged() {
    if (widget.onValueRangeChanged != null) {
      ValueRange<V, U> range = ValueRange(
        start: rangeList[0],
        end: rangeList[1],
      );
      ValueRange<String, Never> rangeText = ValueRange(
        start: rangeTextList[0],
        end: rangeTextList[1],
      );
      widget.onValueRangeChanged!(range, rangeText);
    }
  }
}
