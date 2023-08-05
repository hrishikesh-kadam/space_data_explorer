import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../constants/dimensions.dart';
import '../../widgets/query_grid_container.dart';

typedef ChipSelected<T> = void Function(T? value);

class ChoiceChipInputWidget<T> extends StatefulWidget {
  ChoiceChipInputWidget({
    this.keyPrefix = '',
    this.keys,
    required this.title,
    required this.values,
    required this.labels,
    this.iconSize = 32,
    required this.selected,
    this.keyboardTypes,
    this.inputFormattersList,
    required this.textFieldTextAlign,
    this.textFieldWidth = 200,
    this.spacing = 8,
    this.onChipSelected,
    this.onTextChanged,
  }) : super(key: Key('$keyPrefix$defaultKey'));

  final String keyPrefix;
  final Set<String>? keys;
  final String title;
  final Set<T> values;
  final Set<String> labels;
  final double iconSize;
  final T? selected;
  final List<TextInputType>? keyboardTypes;
  final List<List<TextInputFormatter>?>? inputFormattersList;
  final TextAlign textFieldTextAlign;
  final double textFieldWidth;
  final double spacing;
  final ChipSelected<T>? onChipSelected;
  final ValueChanged<String>? onTextChanged;
  static const String titleKey = 'title_key';
  static const String textFieldKey = 'text_field_key';
  static const String defaultKey = 'choice_chip_input_widget_key';

  @override
  State<ChoiceChipInputWidget<T>> createState() =>
      _ChoiceChipInputWidgetState<T>();
}

class _ChoiceChipInputWidgetState<T> extends State<ChoiceChipInputWidget<T>> {
  int? selectedIndex;
  late final List<String> textList;
  late final TextEditingController textController;
  late FocusNode textFieldFocusNode;
  StreamSubscription<bool>? keyboardSubscription;
  bool? keyboardVisible;

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      final index = widget.values.toList().indexOf(widget.selected as T);
      selectedIndex = index >= 0 ? index : null;
    }
    textList = List.generate(widget.values.length, (index) => '');
    textController = TextEditingController();
    textFieldFocusNode = FocusNode();
    if (widget.keyboardTypes != null) {
      final keyboardVisibilityController = KeyboardVisibilityController();
      keyboardVisible = keyboardVisibilityController.isVisible;
      keyboardSubscription =
          keyboardVisibilityController.onChange.listen((bool visible) {
        keyboardVisible = visible;
      });
    }
  }

  @override
  void dispose() {
    textController.dispose();
    textFieldFocusNode.dispose();
    keyboardSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: Column(
        children: [
          Text(
            key: Key('${widget.keyPrefix}${ChoiceChipInputWidget.titleKey}'),
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: widget.spacing),
          _getChoiceChips(context: context),
          const SizedBox(height: Dimensions.cadQueryItemPadding),
          _getTextField(context: context),
        ],
      ),
    );
  }

  Widget _getChoiceChips({
    required BuildContext context,
  }) {
    return Wrap(
      spacing: widget.spacing,
      runSpacing: widget.spacing,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(
        widget.values.length,
        (index) {
          return TextFieldTapRegion(
            child: ChoiceChip(
              key: widget.keys != null
                  ? Key('${widget.keyPrefix}${widget.keys!.elementAt(index)}')
                  : null,
              label: Text(
                widget.labels.elementAt(index),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              selected: selectedIndex == index,
              onSelected: (selected) {
                setState(() {
                  selectedIndex = selected ? index : null;
                  if (selectedIndex != null) {
                    if (widget.keyboardTypes != null &&
                        textFieldFocusNode.hasFocus &&
                        keyboardVisible == true) {
                      // To change the keyboard
                      textFieldFocusNode.unfocus();
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => textFieldFocusNode.requestFocus(),
                      );
                    }
                    textController.text = textList[selectedIndex!];
                  }
                });
                if (widget.onChipSelected != null) {
                  final T? value =
                      selected ? widget.values.elementAt(index) : null;
                  widget.onChipSelected!(value);
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _getTextField({
    required BuildContext context,
  }) {
    return SizedBox(
      width: widget.textFieldWidth,
      child: TextField(
        key: Key('${widget.keyPrefix}${ChoiceChipInputWidget.textFieldKey}'),
        enabled: selectedIndex != null,
        controller: textController,
        focusNode: textFieldFocusNode,
        keyboardType: widget.keyboardTypes != null && selectedIndex != null
            ? widget.keyboardTypes![selectedIndex!]
            : null,
        inputFormatters:
            widget.inputFormattersList != null && selectedIndex != null
                ? widget.inputFormattersList![selectedIndex!]
                : null,
        textAlign: widget.textFieldTextAlign,
        decoration: const InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
        ),
        onTapOutside: (event) {
          textFieldFocusNode.unfocus();
        },
        onChanged: (value) {
          setState(() {
            textList[selectedIndex!] = value;
          });
          if (widget.onTextChanged != null) {
            widget.onTextChanged!(value);
          }
        },
      ),
    );
  }
}
