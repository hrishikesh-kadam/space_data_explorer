import 'package:flutter/material.dart';

import '../../deferred_widget.dart';
import '../base_page.dart';
import '../home_page.dart';
import 'nasa_source_screen.dart' deferred as nasa_source_screen;

class NasaSourcePage extends BasePage {
  const NasaSourcePage({
    required super.child,
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  static const String pageName = 'nasa-source';
  static const String path = '${HomePage.path}$pageName';
}

final nasaSourcePage = NasaSourcePage(
  child: DeferredWidget(
    nasa_source_screen.loadLibrary,
    () => nasa_source_screen.NasaSourceScreen(),
    placeholder:
        const DeferredLoadingPlaceholder(name: NasaSourcePage.pageName),
  ),
);
