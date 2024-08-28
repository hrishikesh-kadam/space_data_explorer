import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';

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
    final l10n = AppLocalizations.of(context);
    final title = l10n.about;
    return DeferredWidget(
      about_screen.loadLibrary,
      () => about_screen.AboutScreen(
        title: title,
        l10n: l10n,
      ),
      placeholder: DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }
}
