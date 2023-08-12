import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';

import '../constants/constants.dart';
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

enum StateMethod { initState, didUpdateWidget }

class _ValueRangeFilterWidgetState<V, U>
    extends State<ValueRangeFilterWidget<V, U>> {
  final List<ValueUnit<V, U>> rangeList = [];
  final List<ValueUnit<String, void>> rangeTextList = [];
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
      child: _getBody(context: context),
    );
  }

  Widget _getBody({
    required BuildContext context,
  }) {
    prepareState();
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
    for (int i = 0; i < 2; i++) {
      V? value = rangeList[i].value;
      String text = rangeTextList[i].value ?? '';
      final V? defaultValue = defaultRangeList[i]?.value;
      // logger.info(
      //   '_getBody -> $i -> hasFocus = ${textFocusNodes[i].hasFocus}',
      // );
      // logger.info(
      //   '_getBody -> $i -> '
      //   'hasPrimaryFocus = ${textFocusNodes[i].hasPrimaryFocus}',
      // );
      // Still Editing, so ignore updates
      if (!textFocusNodes[i].hasFocus) {
        if (value == null &&
            // If view rebuilds after coming back in viewport
            text.isEmpty &&
            defaultValue != null) {
          value = defaultValue;
          rangeList[i] = rangeList[i].copyWith(value: defaultValue);
          rangeTextList[i] = ValueUnit(value: defaultValue.toString());
        }
        // If in case of any mismatch then fallback to source value
        if (value != widget.valueParser(text)) {
          text = value?.toString() ?? '';
          rangeTextList[i] = ValueUnit(value: text);
        }
        if (textControllers[i].text != text) {
          textControllers[i].text = text;
        }
      }
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
        getUnitDropdown(index: index),
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
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget getValueTextField({
    required int index,
  }) {
    return SizedBox(
      width: widget.textFieldWidth,
      child: TapRegion(
        onTapOutside: (event) {
          logger.debug('TapRegion -> onTapOutside -> $index');
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
                // value as false in _getBody()
                textControllers[index].text = rangeTextList[index].value!;
              });
              callOnValueRangeChanged();
            }
            // logger.info(
            //   'TapRegion -> onTapOutside -> $index -> '
            //   'hasFocus = ${textFocusNodes[index].hasFocus}',
            // );
            // logger.info(
            //   'TapRegion -> onTapOutside -> $index -> '
            //   'hasPrimaryFocus = ${textFocusNodes[index].hasPrimaryFocus}',
            // );
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
            logger.debug('TextField -> onTapOutside -> $index');
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
    );
  }

  dynamic getUnitDropdown({
    required int index,
  }) {
    if (widget.units != null && widget.units!.length == 1) {
      return Text(
        widget.unitSymbols!.first,
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else if (widget.units != null && widget.units!.length >= 2) {
      final List<DropdownMenuItem<U>> dropDownItems = [];
      for (int j = 0; j < widget.units!.length; j++) {
        dropDownItems.add(DropdownMenuItem(
          value: widget.units!.elementAt(j),
          child: Text(
            widget.unitSymbols!.elementAt(j),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ));
      }
      return DropdownButton<U>(
        items: dropDownItems,
        value: rangeList[index].unit ?? widget.units!.first,
        onChanged: (unit) {
          assert(unit != null);
          rangeList[index] = rangeList[index].copyWith(unit: unit);
          callOnValueRangeChanged();
        },
      );
    } else {
      return;
    }
  }

  void callOnValueRangeChanged() {
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
