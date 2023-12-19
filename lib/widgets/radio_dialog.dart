import 'package:flutter/material.dart';

typedef RadioListTileSelected<T> = void Function(T value, int index);

class RadioDialog<T> extends StatelessWidget {
  const RadioDialog({
    this.keyPrefix = '',
    super.key,
    this.icon,
    required this.title,
    required this.values,
    required this.valueTitles,
    this.groupValue,
    this.onSelected,
  });

  final String keyPrefix;
  final Widget? icon;
  final String title;
  final Set<T> values;
  final Set<String> valueTitles;
  final T? groupValue;
  final RadioListTileSelected<T?>? onSelected;

  static const String keyPrefixDefault = 'radio_dialog_';
  static const String keySuffixDefault = '${keyPrefixDefault}key';
  static const String listViewKeySuffix = 'list_view_key';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      title: Text(title),
      content: SizedBox(
        // 360−(40*2)−(24*2) = 232
        // Screen width - (AlertDialog Padding * 2) - (contentPadding * 2)
        // Gets only 232 on 360 wide screen, but if screen has more width then
        // let this be as wide as 320.
        width: 320,
        child: ListView.builder(
          key: keyPrefix.isEmpty ? null : Key('$keyPrefix$listViewKeySuffix'),
          shrinkWrap: true,
          itemCount: values.length,
          itemBuilder: (context, index) {
            return RadioListTile<T>(
              contentPadding: const EdgeInsets.all(0),
              key: keyPrefix.isNotEmpty
                  ? Key('$keyPrefix${valueTitles.elementAt(index)}')
                  : null,
              value: values.elementAt(index),
              title: Text(valueTitles.elementAt(index)),
              groupValue: groupValue,
              onChanged: (value) {
                if (onSelected != null) {
                  onSelected!(value, index);
                }
              },
              toggleable: true,
            );
          },
        ),
      ),
    );
  }
}
