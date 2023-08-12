import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../globals.dart';
import '../helper/helper.dart';
import 'query_grid_container.dart';

typedef ValueParser<V> = V? Function(String text);
typedef ValueRangeChanged<V, U> = void Function(
  ValueRange<V, U> range,
  ValueRange<String, void> rangeText,
);

class ValueRangeFilterWidget<V, U> extends StatefulWidget {
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
    this.onValueRangeChanged,
    this.spacing = 8,
  })  : assert(labels.length == 2),
        assert(units?.length == unitSymbols?.length);

  final String keyPrefix;
  final String title;
  final Set<String> labels;
  final ValueRange<V, U> range;
  final ValueRange<String, void> rangeText;
  final ValueRange<V, U>? defaultRange;
  final ValueParser<V> valueParser;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textFieldTextAlign;
  final double textFieldWidth;
  final Set<U>? units;
  final Set<String>? unitSymbols;
  final double spacing;
  final ValueRangeChanged<V, U>? onValueRangeChanged;
  static const String defaultKey = 'value_range_filter_widget_key';

  @override
  State<ValueRangeFilterWidget<V, U>> createState() =>
      _ValueRangeFilterWidgetState<V, U>();
}

class _ValueRangeFilterWidgetState<V, U>
    extends State<ValueRangeFilterWidget<V, U>> {
  late final List<ValueUnit<V, U>> rangeList;
  late final List<ValueUnit<String, void>> rangeTextList;
  late final List<ValueUnit<V, U>?> defaultRangeList;
  late final List<TextEditingController> textControllers;
  late final List<FocusNode> textFocusNodes;

  @override
  void initState() {
    super.initState();
    rangeList = [];
    assert(widget.range.start != null);
    rangeList.add(widget.range.start!);
    assert(widget.range.end != null);
    rangeList.add(widget.range.end!);
    rangeTextList = [];
    assert(widget.rangeText.start != null);
    rangeTextList.add(widget.rangeText.start!);
    assert(widget.rangeText.end != null);
    rangeTextList.add(widget.rangeText.end!);
    defaultRangeList = [];
    defaultRangeList.add(widget.defaultRange?.start);
    defaultRangeList.add(widget.defaultRange?.end);
    textControllers = [];
    textControllers
      ..add(TextEditingController())
      ..add(TextEditingController());
    textFocusNodes = [];
    textFocusNodes
      ..add(FocusNode())
      ..add(FocusNode());
  }

  @override
  void didUpdateWidget(covariant ValueRangeFilterWidget<V, U> oldWidget) {
    super.didUpdateWidget(oldWidget);
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
  }

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: _getBody(context: context),
    );
  }

  Widget _getBody({
    required BuildContext context,
  }) {
    for (int i = 0; i < 2; i++) {
      V? value = rangeList[i].value;
      String text = rangeTextList[i].value ?? '';
      final V? defaultValue = defaultRangeList[i]?.value;
      if (!textFocusNodes[i].hasFocus) {
        if (value == null && defaultValue != null) {
          value = defaultValue;
          rangeList[i] = rangeList[i].copyWith(value: defaultValue);
          rangeTextList[i] = ValueUnit(value: defaultValue.toString());
        }
        if (value != widget.valueParser(text)) {
          text = value?.toString() ?? '';
          rangeTextList[i] = ValueUnit(value: text);
        }
        if (textControllers[i].text != text) {
          textControllers[i].text = text;
        }
      }
    }
    double largestLabelWidth = getLargestTextWidth(
      context: context,
      textList: widget.labels.toList(),
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
        _getValueWrap(
          context: context,
          index: 0,
          largestLabelWidth: largestLabelWidth,
        ),
        SizedBox(height: widget.spacing),
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
    if (widget.units != null && widget.units!.length >= 2) {
      dropDownItems = [];
      for (int j = 0; j < widget.units!.length; j++) {
        dropDownItems.add(DropdownMenuItem(
          value: widget.units!.elementAt(j),
          child: Text(
            widget.unitSymbols!.elementAt(j),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ));
      }
    }
    return Wrap(
      spacing: 16,
      runSpacing: widget.spacing,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: largestLabelWidth,
          child: Text(
            widget.labels.elementAt(index),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.end,
          ),
        ),
        SizedBox(
          width: widget.textFieldWidth,
          child: TapRegion(
            onTapOutside: (event) {
              log.debug('TapRegion -> onTapOutside -> $index');
              if (textFocusNodes[index].hasFocus) {
                if (textControllers[index].text.isEmpty &&
                    defaultRangeList[index]?.value != null) {
                  setState(() {
                    rangeList[index] = defaultRangeList[index]!;
                    rangeTextList[index] = ValueUnit(
                      value: defaultRangeList[index]!.value!.toString(),
                    );
                  });
                  if (widget.onValueRangeChanged != null) {
                    ValueRange<V, U> range = ValueRange(
                      start: rangeList[0],
                      end: rangeList[1],
                    );
                    ValueRange<String, void> rangeText = ValueRange(
                      start: rangeTextList[0],
                      end: rangeTextList[1],
                    );
                    widget.onValueRangeChanged!(range, rangeText);
                  }
                }
              }
            },
            child: TextField(
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
                log.debug('onTapOutside -> $index');
                if (textFocusNodes[index].hasFocus) {
                  textFocusNodes[index].unfocus();
                }
              },
              onChanged: (text) {
                rangeTextList[index] = ValueUnit(value: text);
                V? value = widget.valueParser(text);
                rangeList[index] = rangeList[index].copyWith(value: value);
                if (widget.onValueRangeChanged != null) {
                  ValueRange<V, U> range = ValueRange(
                    start: rangeList[0],
                    end: rangeList[1],
                  );
                  ValueRange<String, void> rangeText = ValueRange(
                    start: rangeTextList[0],
                    end: rangeTextList[1],
                  );
                  widget.onValueRangeChanged!(range, rangeText);
                }
              },
            ),
          ),
        ),
        if (widget.units != null && widget.units!.length == 1)
          Text(
            widget.unitSymbols!.first,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        if (widget.units != null && widget.units!.length >= 2)
          DropdownButton<U>(
            items: dropDownItems,
            value: rangeList[index].unit ?? widget.units!.first,
            onChanged: (unit) {
              assert(unit != null);
              rangeList[index] = rangeList[index].copyWith(unit: unit);
              if (widget.onValueRangeChanged != null) {
                ValueRange<V, U> range = ValueRange(
                  start: rangeList[0],
                  end: rangeList[1],
                );
                ValueRange<String, void> rangeText = ValueRange(
                  start: rangeTextList[0],
                  end: rangeTextList[1],
                );
                widget.onValueRangeChanged!(range, rangeText);
              }
            },
          ),
      ],
    );
  }
}
