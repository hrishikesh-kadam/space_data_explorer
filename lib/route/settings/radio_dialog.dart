import 'package:flutter/material.dart';

class RadioDialog<T> extends StatelessWidget {
  const RadioDialog({
    super.key,
    required this.title,
    required this.valueList,
    required this.titleStringList,
    this.groupValue,
    this.onChanged,
  });

  final String title;
  final List<T> valueList;
  final List<String> titleStringList;
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
          itemCount: valueList.length,
          itemBuilder: (context, index) {
            return RadioListTile<T>(
              value: valueList[index],
              title: Text(titleStringList[index]),
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
