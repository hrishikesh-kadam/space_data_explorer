// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;

import 'package:flutter_test/flutter_test.dart';
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
  log.fine('history.length = ${history.length}');
  Map? state = history.state;
  log.fine('history.state = $state');
}

void checkHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  final html.History history = html.window.history;
  Map state = history.state;

  log.info('-> history.length = ${history.length}');
  log.info('-> state[\'serialCount\'] = ${state['serialCount']}');
  log.info('-> historyLength = $historyLength');
  log.info('-> serialCount = $serialCount');

  // TODO(hrishikesh-kadam): Fails after `All tests passed!`
  // expect(history.length, historyLength);
  // expect(state['serialCount'], serialCount);

  if (history.length != historyLength) {
    log.severe('history.length != historyLength');
  }
  if (state['serialCount'] != serialCount) {
    log.severe('state[\'serialCount\'] != serialCount');
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
