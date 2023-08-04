import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/dimensions.dart';
import '../../widgets/query_grid_container.dart';

class SegmentedInputWidget<T> extends StatefulWidget {
  const SegmentedInputWidget({
    super.key,
    required this.title,
    required this.segmentValues,
    required this.segmentLabels,
    this.segmentIcons,
    this.segmentedIconSize = 32,
    required this.selected,
    this.keyboardTypes,
    this.inputFormattersList,
    required this.textFieldTextAlign,
    this.textFieldWidth = 200,
    this.spacing = 8,
    this.onSelectionChanged,
    this.onTextChanged,
  });

  final String title;
  final Set<T> segmentValues;
  final Set<String> segmentLabels;
  final Set<IconData>? segmentIcons;
  final double segmentedIconSize;
  final T selected;
  final List<TextInputType>? keyboardTypes;
  final List<List<TextInputFormatter>?>? inputFormattersList;
  final TextAlign textFieldTextAlign;
  final double textFieldWidth;
  final double spacing;
  final ValueChanged<T>? onSelectionChanged;
  final ValueChanged<String>? onTextChanged;

  @override
  State<SegmentedInputWidget<T>> createState() =>
      _SegmentedInputWidgetState<T>();
}

class _SegmentedInputWidgetState<T> extends State<SegmentedInputWidget<T>> {
  late int selectedIndex;
  late final List<String> textList;
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.segmentValues.toList().indexOf(widget.selected);
    textList = List.generate(widget.segmentValues.length, (index) => '');
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
          SegmentedButton<T>(
            segments: List.generate(widget.segmentValues.length, (index) {
              return ButtonSegment<T>(
                value: widget.segmentValues.elementAt(index),
                label: Text(widget.segmentLabels.elementAt(index)),
                icon: widget.segmentIcons != null
                    ? Icon(
                        widget.segmentIcons!.elementAt(index),
                        size: widget.segmentedIconSize,
                      )
                    : null,
              );
            }),
            selected: <T>{widget.segmentValues.elementAt(selectedIndex)},
            onSelectionChanged: (changedSelection) {
              setState(() {
                selectedIndex = widget.segmentValues
                    .toList()
                    .indexOf(changedSelection.first);
                textController.text = textList[selectedIndex];
              });
              if (widget.onSelectionChanged != null) {
                widget.onSelectionChanged!(changedSelection.first);
              }
            },
          ),
          const SizedBox(height: Dimensions.cadQueryItemPadding),
          SizedBox(
            width: widget.textFieldWidth,
            child: TextField(
              controller: textController,
              keyboardType: widget.keyboardTypes != null
                  ? widget.keyboardTypes![selectedIndex]
                  : null,
              inputFormatters: widget.inputFormattersList != null
                  ? widget.inputFormattersList![selectedIndex]
                  : null,
              textAlign: widget.textFieldTextAlign,
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  textList[selectedIndex] = value;
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
