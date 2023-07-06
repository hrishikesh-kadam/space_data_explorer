import 'package:flutter/material.dart';

import '../../../deferred_loading/deferred_widget.dart';
import '../../../pages/base_page.dart';
import '../cad_page.dart';
import 'cad_result_screen.dart' deferred as cad_result_screen;

class CadResultPage extends BasePage {
  const CadResultPage({
    required super.child,
    super.key = const ValueKey(pageName),
    super.name = pageName,
    super.previousPage,
  });

  static const String pageName = 'result';
  static const String displayName = 'SBDB Close-Approach Data Result';
  static const String path = '${CadPage.path}/$pageName';
}

final cadResultPage = CadResultPage(
  child: DeferredWidget(
    cad_result_screen.loadLibrary,
    () => cad_result_screen.CadResultScreen(),
    placeholder:
        const DeferredLoadingPlaceholder(name: CadResultPage.displayName),
  ),
);
