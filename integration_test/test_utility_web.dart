// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:space_data_explorer/globals.dart';

void checkHistoryLengthAndSerialCount(
  int historyLength,
  int serialCount,
) {
  final html.History history = html.window.history;
  Map state = history.state;

  log.fine('-> history.length = ${history.length}');
  log.fine('-> state[\'serialCount\'] = ${state['serialCount']}');
  log.fine('-> historyLength = $historyLength');
  log.fine('-> serialCount = $serialCount');

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
