import 'package:flutter/material.dart';

import 'package:url_launcher/link.dart';

Widget getLabelLinkInkWellWrap({
  required BuildContext context,
  required String text,
  required Uri uri,
  Key? inkWellKey,
}) {
  return Wrap(
    alignment: WrapAlignment.center,
    children: [
      Text(
        '$text: ',
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      Link(
        uri: uri,
        target: LinkTarget.blank,
        builder: (context, followLink) {
          return InkWell(
            key: inkWellKey,
            onTap: followLink,
            child: Text(
              uri.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
            ),
          );
        },
      ),
    ],
  );
}
