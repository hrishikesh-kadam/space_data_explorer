import 'package:flutter/material.dart';

import 'radio_dialog.dart';

class RadioSettingsTile<T> extends StatelessWidget {
  const RadioSettingsTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.values,
    required this.valueTitles,
    this.groupValue,
    this.onChanged,
    this.beforeShowDialog,
    this.afterShowDialog,
  });

  final String title;
  final String subTitle;
  final List<T> values;
  final List<String> valueTitles;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? beforeShowDialog;
  final VoidCallback? afterShowDialog;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () async {
        if (beforeShowDialog != null) beforeShowDialog!();
        await showDialog(
          context: context,
          builder: (context) {
            return RadioDialog<T>(
              title: title,
              values: values,
              valueTitles: valueTitles,
              groupValue: groupValue,
              onChanged: onChanged,
            );
          },
        );
        if (afterShowDialog != null) afterShowDialog!();
      },
    );
  }
}
