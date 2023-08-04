import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/dimensions.dart';
import '../../widgets/query_grid_container.dart';

typedef ChipSelected<T> = void Function(T? value);

class ChoiceChipInputWidget<T> extends StatefulWidget {
  const ChoiceChipInputWidget({
    super.key,
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
  });

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

  @override
  State<ChoiceChipInputWidget<T>> createState() =>
      _ChoiceChipInputWidgetState<T>();
}

class _ChoiceChipInputWidgetState<T> extends State<ChoiceChipInputWidget<T>> {
  int? selectedIndex;
  late final List<String> textList;
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    if (widget.selected != null) {
      final index = widget.values.toList().indexOf(widget.selected as T);
      selectedIndex = index >= 0 ? index : null;
    }
    textList = List.generate(widget.values.length, (index) => '');
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return QueryItemContainer(
      child: Column(
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: widget.spacing),
          Wrap(
            spacing: widget.spacing,
            runSpacing: widget.spacing,
            alignment: WrapAlignment.center,
            children: List<Widget>.generate(
              widget.values.length,
              (index) {
                return ChoiceChip(
                  label: Text(
                    widget.labels.elementAt(index),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  selected: selectedIndex == index,
                  onSelected: (selected) {
                    setState(() {
                      selectedIndex = selected ? index : null;
                      if (selectedIndex != null) {
                        textController.text = textList[selectedIndex!];
                      }
                    });
                    if (widget.onChipSelected != null) {
                      final T? value =
                          selected ? widget.values.elementAt(index) : null;
                      widget.onChipSelected!(value);
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(height: Dimensions.cadQueryItemPadding),
          SizedBox(
            width: widget.textFieldWidth,
            child: TextField(
              enabled: selectedIndex != null,
              controller: textController,
              keyboardType:
                  widget.keyboardTypes != null && selectedIndex != null
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
              onChanged: (value) {
                setState(() {
                  textList[selectedIndex!] = value;
                });
                if (widget.onTextChanged != null) {
                  widget.onTextChanged!(value);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
