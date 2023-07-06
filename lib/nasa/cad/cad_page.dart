import 'package:flutter/material.dart';

import '../../deferred_loading.dart';
import '../../pages/base_page.dart';
import '../nasa_page.dart';
import 'cad_screen.dart' deferred as cad_screen;

class CadPage extends BasePage {
  const CadPage({
    required super.child,
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  static const String pageName = 'cad';
  static const String displayName = 'SBDB Close-Approach Data';
  static const String path = '${NasaPage.path}/$pageName';
}

final cadPage = CadPage(
  child: DeferredWidget(
    cad_screen.loadLibrary,
    () => cad_screen.CadScreen(),
    placeholder: const DeferredLoadingPlaceholder(name: CadPage.displayName),
  ),
);
