import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_batteries/hrk_batteries.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';

import '../../constants/labels.dart';
import '../../deferred_loading/deferred_loading.dart';
import 'page_not_found_screen.dart' deferred as page_not_found_screen;

part 'page_not_found_route.g.dart';

@TypedGoRoute<PageNotFoundRoute>(
  // path: PageNotFoundRoute.uri.path,
  path: '/${PageNotFoundRoute.pathSegment}',
  name: PageNotFoundRoute.displayName,
)
class PageNotFoundRoute extends GoRouteData {
  const PageNotFoundRoute({
    this.$extra,
  });

  final JsonMap? $extra;
  static const String pathSegment = 'page-not-found';
  static final Uri uri = Uri(path: '/$pathSegment');
  static const String displayName = Labels.pageNotFound;
  static final Uri nonExistingUri = Uri(path: '/non-existing-path');

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    // LABEL: possible-bug
    // Unable to get right extra in state for browser forward navigation.
    // Also, after forawrd navigation, two entries are observed for this route.
    // Observed in go_router-10.2.0
    return super.redirect(context, state);
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final l10n = AppLocalizations.of(context);
    final title = l10n.pageNotFound;
    return DeferredWidget(
      page_not_found_screen.loadLibrary,
      () => page_not_found_screen.PageNotFoundScreen(
        title: title,
        extra: $extra,
        l10n: l10n,
      ),
      placeholder: DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }
}
