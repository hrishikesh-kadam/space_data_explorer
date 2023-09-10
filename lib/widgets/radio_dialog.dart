import 'package:flutter/material.dart';

class RadioDialog<T> extends StatelessWidget {
  const RadioDialog({
    super.key,
    required this.title,
    required this.values,
    required this.valueTitles,
    this.groupValue,
    this.onChanged,
  });

  final String title;
  final Set<T> values;
  final Set<String> valueTitles;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.minPositive,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: values.length,
          itemBuilder: (context, index) {
            return RadioListTile<T>(
              key: Key(valueTitles.elementAt(index)),
              value: values.elementAt(index),
              title: Text(valueTitles.elementAt(index)),
              groupValue: groupValue,
              onChanged: onChanged,
              toggleable: true,
            );
          },
        ),
      ),
    );
  }
}
