import 'package:flutter/material.dart';

import '../../deferred_loading.dart';
import '../pages/base_page.dart';
import 'nasa_page.dart';
import 'neows_screen.dart' deferred as neows_screen;

class NeowsPage extends BasePage {
  const NeowsPage({
    required super.child,
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  static const String pageName = 'neows';
  static const String displayName = 'NeoWs';
  static const String path = '${NasaPage.path}/$pageName';
}

final neowsPage = NeowsPage(
  child: DeferredWidget(
    neows_screen.loadLibrary,
    () => neows_screen.NeowsScreen(),
    placeholder: const DeferredLoadingPlaceholder(name: NeowsPage.displayName),
  ),
);
