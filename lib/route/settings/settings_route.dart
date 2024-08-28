import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hrk_flutter_batteries/hrk_flutter_batteries.dart';

import '../../constants/labels.dart';
import '../../deferred_loading/deferred_loading.dart';
import 'settings_screen.dart' deferred as settings_screen;

class SettingsRoute extends GoRouteData {
  const SettingsRoute();

  static const String pathSegment = 'settings';
  static final Uri uri = Uri(path: '/$pathSegment');
  static const String displayName = Labels.settings;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final l10n = AppLocalizations.of(context);
    final title = l10n.settings;
    return DeferredWidget(
      settings_screen.loadLibrary,
      () => settings_screen.SettingsScreen(
        title: title,
        l10n: l10n,
      ),
      placeholder: DeferredPlaceholderWidget(
        title: title,
      ),
    );
  }
}
