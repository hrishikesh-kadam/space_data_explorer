import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'test_utility_non_web.dart'
    if (dart.library.html) 'test_utility_web.dart' as platform;

String getTestType() {
  try {
    IntegrationTestWidgetsFlutterBinding.instance;
    return 'Integration';
  } catch (e) {
    return 'Widget';
  }
}

void resetNavigationHistoryState() {
  platform.resetNavigationHistoryState();
}

void logNavigationHistoryState() {
  platform.logNavigationHistoryState();
}

void checkHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  platform.checkHistoryLengthAndSerialCount(historyLength, serialCount);
}

Future<void> testScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  await platform.testScreenshot(name, tester, binding);
}

// Source - https://github.com/flutter/packages/blob/010ba5012831a4e02349e31965a0b080d7b44280/packages/go_router/test/test_helpers.dart#L283-L288
Future<void> simulateAndroidBackButton(WidgetTester tester) async {
  final ByteData message =
      const JSONMethodCodec().encodeMethodCall(const MethodCall('popRoute'));
  await tester.binding.defaultBinaryMessenger
      .handlePlatformMessage('flutter/navigation', message, (_) {});
}

// Sources -
// 1. https://github.com/flutter/packages/blob/cda21a89692739a3250091f061f9ac9d4bb8060e/packages/go_router/test/go_router_test.dart#L753-L795
// 2. https://github.com/flutter/flutter/blob/3b4ac4d5cc59344170833b93a968ace003f184f0/packages/flutter/test/services/system_navigator_test.dart#L12-L30
Future<void> verifySystemNavigatorPop(WidgetTester tester) async {
  final List<MethodCall> log = <MethodCall>[];
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform,
          (MethodCall methodCall) async {
    log.add(methodCall);
    return null;
  });

  Future<void> verify(AsyncCallback test, List<Object> expectations) async {
    log.clear();
    await test();
    expect(log, expectations);
  }

  await tester.runAsync(() async {
    await verify(() => simulateAndroidBackButton(tester), <Object>[
      isMethodCall('SystemNavigator.pop', arguments: null),
    ]);
  });

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(SystemChannels.platform, null);
}
