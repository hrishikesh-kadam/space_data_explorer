// coverage:ignore-file

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/labels.dart';
import '../../../deferred_loading/deferred_loading.dart';
import '../about_route.dart';
import 'license_screen.dart' deferred as license_screen;

class LicenseRoute extends GoRouteData {
  const LicenseRoute();

  static const String routeName = 'license';
  static const String path = '${AboutRoute.path}/$routeName';
  static const String displayName = Labels.license;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    const title = displayName;
    return DeferredWidget(
      license_screen.loadLibrary,
      () => license_screen.LicenseScreen(
        title: title,
        l10n: AppLocalizations.of(context),
      ),
      placeholder: const DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }
}
