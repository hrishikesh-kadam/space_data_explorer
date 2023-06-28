import 'package:flutter/material.dart';

import '../../deferred_loading.dart';
import '../pages/base_page.dart';
import '../pages/home_page.dart';
import 'nasa_screen.dart' deferred as nasa_source_screen;

class NasaPage extends BasePage {
  const NasaPage({
    required super.child,
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  static const String pageName = 'nasa';
  static const String displayName = 'NASA';
  static const String path = '${HomePage.path}$pageName';
}

final nasaSourcePage = NasaPage(
  child: DeferredWidget(
    nasa_source_screen.loadLibrary,
    () => nasa_source_screen.NasaScreen(),
    placeholder: const DeferredLoadingPlaceholder(name: NasaPage.displayName),
  ),
);
