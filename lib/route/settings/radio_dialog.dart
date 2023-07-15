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
  final List<T> values;
  final List<String> valueTitles;
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
              value: values[index],
              title: Text(valueTitles[index]),
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
