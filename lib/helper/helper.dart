import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// LABEL: eligible-hrk_flutter_batteries
double getLargestTextWidth({
  required BuildContext context,
  required Set<String> textSet,
  TextStyle? style,
  TextScaler? textScaler,
}) {
  textScaler ??= TextScaler.linear(
    View.of(context).platformDispatcher.textScaleFactor,
  );
  double largestWidth = 0;
  for (final text in textSet) {
    final TextPainter textPainter = getTextPainterLaidout(
      context: context,
      text: text,
      style: style,
      textScaler: textScaler,
    );
    if (textPainter.size.width > largestWidth) {
      largestWidth = textPainter.size.width;
    }
  }
  return largestWidth;
}

// LABEL: eligible-hrk_flutter_batteries
TextPainter getTextPainterLaidout({
  required BuildContext context,
  required String text,
  TextStyle? style,
  TextScaler? textScaler,
}) {
  textScaler ??= TextScaler.linear(
    View.of(context).platformDispatcher.textScaleFactor,
  );
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
    textScaler: textScaler,
  );
  textPainter.layout();
  return textPainter;
}

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
