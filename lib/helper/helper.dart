import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

(double, int) getSliverMasonryGridParameters({
  required BuildContext context,
  required double itemBoxWidth,
  double pageMarginHorizontal = 0,
}) {
  final double deviceWidth = MediaQuery.sizeOf(context).width;
  final double whiteSpaceWhenTwo =
      deviceWidth - 2 * itemBoxWidth - 2 * pageMarginHorizontal;
  // logger.debug('deviceWidth = $deviceWidth');
  // logger.debug('whiteSpaceWhenTwo = $whiteSpaceWhenTwo');
  int crossAxisCount;
  double horizontalPadding = pageMarginHorizontal;
  if (whiteSpaceWhenTwo >= 0) {
    crossAxisCount = 2;
    horizontalPadding += whiteSpaceWhenTwo / 2;
  } else {
    final double whiteSpaceWhenOne =
        deviceWidth - itemBoxWidth - 2 * pageMarginHorizontal;
    // logger.debug('whiteSpaceWhenOne = $whiteSpaceWhenOne');
    if (whiteSpaceWhenOne >= 0) {
      crossAxisCount = 1;
      horizontalPadding += whiteSpaceWhenOne / 2;
    } else {
      crossAxisCount = 1;
    }
  }
  // logger.debug('horizontalPadding = $horizontalPadding');
  return (horizontalPadding, crossAxisCount);
}

void copyToClipboard({
  required BuildContext context,
  required String text,
}) {
  Clipboard.setData(ClipboardData(text: text));
  final snackBar = SnackBar(
    content: Text(AppLocalizations.of(context).copiedToClipboard),
  );
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}
