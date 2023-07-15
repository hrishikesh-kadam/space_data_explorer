import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

List getListOfRouteMatch(BuildContext context) {
  return GoRouter.of(context).routerDelegate.currentConfiguration.matches;
}

class DateFormatJsonConverter implements JsonConverter<DateFormat, String?> {
  const DateFormatJsonConverter();

  @override
  DateFormat fromJson(String? pattern) => DateFormat(pattern);

  @override
  String? toJson(DateFormat dateFormat) => dateFormat.pattern;
}
