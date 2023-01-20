import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/config/configure_app.dart';
import 'package:space_data_explorer/globals.dart';

void main() {
  test('configureLogging() Unit Test', () async {
    configureLogging();
    log.shout('sample shout');
    log.severe('sample severe');
    log.warning('sample warning');
    log.info('sample info');
    log.fine('sample fine');
    log.finer('sample finer');
    log.finest('sample finest');
  });
}
