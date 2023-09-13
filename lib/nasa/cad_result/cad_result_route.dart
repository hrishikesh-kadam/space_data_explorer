import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hrk_nasa_apis/hrk_nasa_apis.dart';
import 'package:intl/intl.dart';

import '../../../deferred_loading/deferred_loading.dart';
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

  static const String routeName = 'result';
  static const String path = '${CadRoute.path}/$routeName';
  static const String displayName = 'SBDB Close-Approach Data Result';

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    _logger.debug('redirect');
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
    return CadRoute.path;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final locale = Localizations.localeOf(context).toString();
    // final zeroDigit = NumberFormat(null, locale).symbols.ZERO_DIGIT;
    final zeroDigit = DateFormat(null, locale).dateSymbols.ZERODIGIT ?? '0';

    return DeferredWidget(
      cad_result_screen.loadLibrary,
      () => cad_result_screen.CadResultScreen(
        l10n: AppLocalizations.of(context),
        routeExtraMap: $extra!,
        zeroDigit: zeroDigit,
      ),
      placeholder: const DeferredPlaceholderWidget(
        name: CadResultRoute.displayName,
      ),
    );
  }

  // void mockSampleResponse() {
  //   if ($extra == null) {
  //     $extra = {};
  //     $extra!['$SbdbCadBody'] = SbdbCadBodyExt.getSample('200/1');
  //   }
  // }
}
