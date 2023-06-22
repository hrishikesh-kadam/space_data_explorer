import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'package:space_data_explorer/config/configure_app.dart';
import 'package:space_data_explorer/globals.dart';

// TODO(hrishikesh-kadam): Start integrating Checks package.
// https://pub.dev/packages/checks

void main() {
  test('configureLogging() Unit Test', () async {
    configureLogging();
    log.level = Level.ALL;
    log.shout('sample shout');
    log.severe('sample severe');
    log.warning('sample warning');
    log.info('sample info');
    log.fine('sample fine');
    log.finer('sample finer');
    log.finest('sample finest');
  });
}
