import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:intl/intl.dart';

import '../../../deferred_loading/deferred_loading.dart';
import '../../constants/labels.dart';
import '../../globals.dart';
import '../cad/cad_route.dart';
import 'cad_result_screen.dart' deferred as cad_result_screen;

class CadResultRoute extends GoRouteData {
  CadResultRoute({
    this.$extra,
  }) {
    // mockSampleResponse();
  }

  JsonMap? $extra;
  final _logger = Logger('$appNamePascalCase.CadResultRoute');

  static const String pathSegment = 'result';
  static final Uri uri = Uri(path: '${CadRoute.uri.path}/$pathSegment');
  static const String displayName = Labels.sbdbCloseApproachDataResult;
  @visibleForTesting
  static JsonMap? $extraTest;

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    _logger.debug('redirect');
    stubExtraForTesting();
    if ($extra != null) {
      final JsonMap extra = $extra!;
      if (extra.containsKey('$SbdbCadBody')) {
        if (extra['$SbdbCadBody'] is SbdbCadBody) {
          _logger.debug('redirect -> extra[SbdbCadBody] is SbdbCadBody');
          return null;
        } else if (extra['$SbdbCadBody'] is JsonMap) {
          _logger.debug('redirect -> extra[SbdbCadBody] is JsonMap');
          extra['$SbdbCadBody'] = SbdbCadBody.fromJson(extra['$SbdbCadBody']);
          return null;
        }
      }
    }
    return CadRoute.uri.path;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    stubExtraForTesting();
    final l10n = AppLocalizations.of(context);
    final title = l10n.cadResultRouteName;
    final locale = Localizations.localeOf(context).toString();
    // final zeroDigit = NumberFormat(null, locale).symbols.ZERO_DIGIT;
    final zeroDigit = DateFormat(null, locale).dateSymbols.ZERODIGIT ?? '0';
    return DeferredWidget(
      cad_result_screen.loadLibrary,
      () => cad_result_screen.CadResultScreen(
        title: title,
        l10n: l10n,
        routeExtraMap: $extra!,
        zeroDigit: zeroDigit,
      ),
      placeholder: DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }

  @visibleForTesting
  void stubExtraForTesting() {
    if (flutterTest && $extraTest != null) {
      $extra = $extraTest;
    }
  }

  // void mockSampleResponse() {
  //   if ($extra == null) {
  //     $extra = {};
  //     $extra!['$SbdbCadBody'] = SbdbCadBodyExt.getSample('200/1');
  //   }
  // }
}
