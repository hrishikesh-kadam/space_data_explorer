import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../constants/labels.dart';
import '../../deferred_loading/deferred_loading.dart';
import 'about_screen.dart' deferred as about_screen;

class AboutRoute extends GoRouteData {
  const AboutRoute();

  static const String pathSegment = 'about';
  static final Uri uri = Uri(path: '/$pathSegment');
  static const String displayName = Labels.about;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    const title = displayName;
    return DeferredWidget(
      about_screen.loadLibrary,
      () => about_screen.AboutScreen(
        title: title,
        l10n: AppLocalizations.of(context),
      ),
      placeholder: const DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }
}
