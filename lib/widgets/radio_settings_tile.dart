import 'package:flutter/material.dart';

import 'radio_dialog.dart';

class RadioSettingsTile<T> extends StatelessWidget {
  const RadioSettingsTile({
    this.keyPrefix = '',
    super.key,
    required this.title,
    this.subTitle,
    required this.values,
    required this.valueTitles,
    this.groupValue,
    this.onChanged,
    this.beforeShowDialog,
    this.afterShowDialog,
  });

  final String keyPrefix;
  final String title;
  final String? subTitle;
  final Set<T> values;
  final Set<String> valueTitles;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final VoidCallback? beforeShowDialog;
  final VoidCallback? afterShowDialog;

  static const String keyPrefixDefault = 'radio_settings_tile_';
  static const String keySuffixDefault = '${keyPrefixDefault}key';

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
              keyPrefix: keyPrefix.isNotEmpty
                  ? '$keyPrefix${RadioDialog.keyPrefixDefault}'
                  : '',
              key: keyPrefix.isNotEmpty
                  ? Key('$keyPrefix${RadioDialog.keySuffixDefault}')
                  : null,
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
