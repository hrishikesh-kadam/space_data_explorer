import 'package:flutter/material.dart';

import 'package:url_launcher/link.dart';

Widget getLinkWrap({
  required BuildContext context,
  required String text,
  required Uri uri,
  Key? uriKey,
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
            key: uriKey,
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
