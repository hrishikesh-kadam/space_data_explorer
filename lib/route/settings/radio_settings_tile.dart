import 'package:flutter/material.dart';

import 'radio_dialog.dart';

class RadioSettingsTile<T> extends StatelessWidget {
  const RadioSettingsTile({
    super.key,
    this.dialogKey,
    required this.title,
    this.subTitle,
    required this.values,
    required this.valueTitles,
    this.groupValue,
    this.onChanged,
    this.beforeShowDialog,
    this.afterShowDialog,
  });

  final Key? dialogKey;
  final String title;
  final String? subTitle;
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
      subtitle: subTitle != null ? Text(subTitle!) : null,
      onTap: () async {
        if (beforeShowDialog != null) beforeShowDialog!();
        await showDialog(
          context: context,
          builder: (context) {
            return RadioDialog<T>(
              key: dialogKey,
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
