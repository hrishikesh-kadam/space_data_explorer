import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';

import '../../constants/constants.dart';
import 'radio_dialog.dart';

class RadioSettingsTile<T> extends StatelessWidget {
  RadioSettingsTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.values,
    required this.valueTitles,
    this.groupValue,
    this.onChanged,
  });

  final String title;
  final String subTitle;
  final List<T> values;
  final List<String> valueTitles;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final _log = Logger('$appNamePascalCase.RadioSettingsTile');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: () async {
        _log.debug('-> before showDialog');
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
        _log.debug('-> after showDialog');
      },
    );
  }
}
