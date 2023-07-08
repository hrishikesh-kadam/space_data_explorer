// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:integration_test/integration_test.dart';

import 'globals.dart';

void resetNavigationHistoryState() {
  final html.History history = html.window.history;
  Map? state = history.state;
  if (state != null) {
    history.go(-(history.length - 1));
  }
  // history.replaceState(null, '', null);
}

void logNavigationHistoryState() {
  final html.History history = html.window.history;
  testLog.fine('history.length = ${history.length}');
  Map? state = history.state;
  testLog.fine('history.state = $state');
}

bool verifyHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  final html.History history = html.window.history;
  Map state = history.state;

  testLog.finer('-> history.length = ${history.length}');
  testLog.finer('-> state[\'serialCount\'] = ${state['serialCount']}');
  testLog.finer('-> historyLength = $historyLength');
  testLog.finer('-> serialCount = $serialCount');

  // TODO(hrishikesh-kadam): Fails after `All tests passed!`
  // expect(history.length, historyLength);
  // expect(state['serialCount'], serialCount);

  bool historyLengthNotEqual = false;
  bool serialCountNotEqual = false;
  if (historyLengthNotEqual = history.length != historyLength) {
    printLog.error('history.length != historyLength');
  }
  if (serialCountNotEqual = state['serialCount'] != serialCount) {
    printLog.error('state[\'serialCount\'] != serialCount');
  }
  if (historyLengthNotEqual || serialCountNotEqual) {
    return false;
  } else {
    return true;
  }
}

Future<void> testScreenshot(
  String name,
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  await tester.pumpAndSettle();
  await binding.takeScreenshot(name);
}
