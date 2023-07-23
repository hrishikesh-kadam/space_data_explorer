import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';

List getListOfRouteMatch(BuildContext context) {
  return GoRouter.of(context).routerDelegate.currentConfiguration.matches;
}

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
