import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

List getListOfRouteMatch(BuildContext context) {
  return GoRouter.of(context).routerDelegate.currentConfiguration.matches;
}

// LABEL: eligible-hrk_batteries
class LocaleJsonConverter implements JsonConverter<Locale?, JsonMap?> {
  const LocaleJsonConverter();

  @override
  Locale? fromJson(JsonMap? json) {
    if (json == null) {
      return null;
    } else {
      return Locale.fromSubtags(
        languageCode: json['languageCode'],
        scriptCode: json['scriptCode'],
        countryCode: json['countryCode'],
      );
    }
  }

  @override
  JsonMap? toJson(Locale? object) {
    if (object == null) {
      return null;
    } else {
      JsonMap json = {};
      json['languageCode'] = object.languageCode;
      if (object.scriptCode != null) {
        json['scriptCode'] = object.scriptCode;
      }
      if (object.countryCode != null) {
        json['countryCode'] = object.countryCode;
      }
      return json;
    }
  }
}

// LABEL: eligible-hrk_batteries
class LocaleListJsonConverter
    implements JsonConverter<List<Locale>?, List<dynamic>?> {
  const LocaleListJsonConverter();

  @override
  List<Locale>? fromJson(List<dynamic>? jsonList) {
    if (jsonList == null || jsonList.isEmpty) {
      return null;
    } else {
      return jsonList.map((e) {
        return const LocaleJsonConverter().fromJson(e)!;
      }).toList();
    }
  }

  @override
  List<JsonMap>? toJson(List<Locale>? localeList) {
    if (localeList == null || localeList.isEmpty) {
      return null;
    } else {
      return localeList.map((e) {
        return const LocaleJsonConverter().toJson(e)!;
      }).toList();
    }
  }
}

// LABEL: eligible-hrk_flutter_batteries
double getLargestTextWidth({
  required BuildContext context,
  required Set<String> textSet,
  TextStyle? style,
  double? textScaleFactor,
}) {
  textScaleFactor ??= View.of(context).platformDispatcher.textScaleFactor;
  double largestWidth = 0;
  for (final text in textSet) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
      // TODO(hrishikesh-kadam): Use TextScaler once it is in stable
      // ignore: deprecated_member_use
      textScaleFactor: textScaleFactor,
    );
    textPainter.layout();
    if (textPainter.size.width > largestWidth) {
      largestWidth = textPainter.size.width;
    }
  }
  return largestWidth;
}

(double, int) getSliverMasonryGridParameters({
  required BuildContext context,
  required double itemExtent,
  double pagePaddingHorizontal = 0,
}) {
  final double deviceWidth = MediaQuery.sizeOf(context).width;
  final double whiteSpaceWhenTwo =
      deviceWidth - 2 * itemExtent - 2 * pagePaddingHorizontal;
  // logger.debug('deviceWidth = $deviceWidth');
  // logger.debug('whiteSpaceWhenTwo = $whiteSpaceWhenTwo');
  int crossAxisCount;
  double horizontalPadding = pagePaddingHorizontal;
  if (whiteSpaceWhenTwo >= 0) {
    crossAxisCount = 2;
    horizontalPadding += whiteSpaceWhenTwo / 2;
  } else {
    final double whiteSpaceWhenOne =
        deviceWidth - itemExtent - 2 * pagePaddingHorizontal;
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
