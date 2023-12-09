import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'helper_non_web.dart' if (dart.library.html) 'helper_web.dart'
    as platform;

void resetNavigationHistoryState() {
  platform.resetNavigationHistoryState();
}

void logNavigationHistoryState() {
  platform.logNavigationHistoryState();
}

bool expectHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  return platform.expectHistoryLengthAndSerialCount(historyLength, serialCount);
}

Future<void> testScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  await platform.testScreenshot(name, tester, binding);
}

// LABEL: eligible-hrk_flutter_test_batteries
Future<void> tap(
  WidgetTester tester, {
  required Finder finder,
  bool warnIfMissed = true,
}) async {
  await tester.tap(finder, warnIfMissed: warnIfMissed);
  await tester.pumpAndSettle();
}

void expectCrossAxisCount(
  WidgetTester tester, {
  required int count,
  required Finder itemFinder,
}) {
  final gridItems = tester.widgetList(itemFinder).toList();
  final firstItemRect = tester.getRect(find.byWidget(gridItems[0]));
  final secondItemRect = tester.getRect(find.byWidget(gridItems[1]));
  final thirdItemRect = tester.getRect(find.byWidget(gridItems[2]));
  if (count == 2) {
    expect(firstItemRect.top == secondItemRect.top, true);
    expect(secondItemRect.top < thirdItemRect.top, true);
  } else if (count == 1) {
    expect(firstItemRect.top < secondItemRect.top, true);
    expect(secondItemRect.top < thirdItemRect.top, true);
  }
}

// LABEL: eligible-hrk_flutter_test_batteries
// Source: https://github.com/flutter/flutter/issues/38997#issuecomment-555687558
Future<void> precacheAllImages(
  WidgetTester tester,
) async {
  await tester.runAsync(() async {
    for (Element element in find.byType(Image).evaluate()) {
      final Image widget = element.widget as Image;
      final ImageProvider image = widget.image;
      await precacheImage(image, element);
    }
  });
  await tester.pumpAndSettle();
}
