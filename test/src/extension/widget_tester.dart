import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

// LABEL: eligible-hrk_flutter_test_batteries
/// References:
/// 1. https://docs.flutter.dev/tools/devtools/inspector#flex-layouts
/// 2. https://docs.flutter.dev/testing/common-errors#a-renderflex-overflowed
extension HrkWidgetTester on WidgetTester {
  List<RenderFlex> getOverflowingRenderFlexList({
    required Finder of,
    bool matchRoot = false,
    bool skipOffstage = true,
  }) {
    final renderFlexList = renderObjectList<RenderFlex>(
      find.descendant(
        of: of,
        matching: find.bySubtype<Flex>(),
        matchRoot: matchRoot,
        skipOffstage: skipOffstage,
      ),
    );
    final overflowingRenderFlexList = <RenderFlex>[];
    for (final renderFlex in renderFlexList) {
      if (renderFlex.toStringShort().contains('OVERFLOWING')) {
        overflowingRenderFlexList.add(renderFlex);
      }
    }
    return overflowingRenderFlexList;
  }
}
