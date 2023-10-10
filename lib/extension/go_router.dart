import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_logging/hrk_logging.dart';

import '../../extension/logger.dart';
import '../../globals.dart';
import '../route/home/home_route.dart';
import '../route/page_not_found/page_not_found_route.dart';

extension GoRouterExt on GoRouter {
  static final _logger = Logger('$appNamePascalCase.GoRouterExt');

  void popOrHomeRoute() {
    if (canPop()) {
      pop();
    } else {
      go(HomeRoute.path);
    }
  }

  void topOrHomeRoute() {
    if (canPop()) {
      do {
        pop();
      } while (canPop());
    } else {
      go(HomeRoute.path);
    }
  }

  static void onException(
    BuildContext context,
    GoRouterState state,
    GoRouter router,
  ) {
    _logger.reportError('onException -> ${state.uri}');
    late final JsonMap extra;
    if (state.extra != null) {
      extra = state.extra as JsonMap;
    } else {
      extra = {};
    }
    extra['$GoRouterState'] = state;
    router.go(PageNotFoundRoute.path, extra: extra);
  }
}
