import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'package:space_data_explorer/config/configure_app.dart';
import 'package:space_data_explorer/globals.dart';

// TODO(hrishikesh-kadam): Keep an eye on Checks package.
// https://pub.dev/packages/checks

void main() {
  group('Logger Unit Test', () {
    test('Print', skip: true, () async {
      configureLogging();
      log.level = Level.ALL;
      log.shout('sample shout');
      log.severe('sample severe');
      log.warning('sample warning');
      log.info('sample info');
      log.debug('sample debug');
      log.fine('sample fine');
      log.finer('sample finer');
      log.finest('sample finest');
    });

    test('Assert', () async {
      String name = 'TestLogger';
      String message = 'sample shout';
      RegExp pattern = RegExp('^$name: '
          '${RegExp.escape('\x1B[31m$shoutEmoji')} Shout: .*'
          '$message'
          '${RegExp.escape('\x1B[39m')}'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = Level.SHOUT;
          log.shout(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );

      message = 'sample severe';
      pattern = RegExp('^$name: '
          '${RegExp.escape('\x1B[31m$severeEmoji')} Severe: .*'
          '$message'
          '${RegExp.escape('\x1B[39m')}'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = Level.SEVERE;
          log.severe(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );

      message = 'sample warning';
      pattern = RegExp('^$name: '
          '${RegExp.escape('\x1B[33m$warningEmoji')} Warning: .*'
          '$message'
          '${RegExp.escape('\x1B[39m')}'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = Level.WARNING;
          log.warning(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );

      message = 'sample info';
      pattern = RegExp('^$name: '
          '${RegExp.escape('\x1B[32m$infoEmoji')} Info: .*'
          '$message'
          '${RegExp.escape('\x1B[39m')}'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = Level.INFO;
          log.info(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );

      message = 'sample debug';
      pattern = RegExp('^$name: '
          '${RegExp.escape('\x1B[34m$debugEmoji')} Debug: .*'
          '$message'
          '${RegExp.escape('\x1B[39m')}'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = DEBUG;
          log.debug(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );

      message = 'sample fine';
      pattern = RegExp('^$name: '
          'Fine: .*'
          '$message'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = Level.FINE;
          log.fine(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );

      message = 'sample finer';
      pattern = RegExp('^$name: '
          'Finer: .*'
          '$message'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = Level.FINER;
          log.finer(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );

      message = 'sample finest';
      pattern = RegExp('^$name: '
          'Finest: .*'
          '$message'
          r'$');
      await runZoned(
        () async {
          configureLogging();
          final log = Logger(name)..level = Level.FINEST;
          log.finest(message);
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) {
            expect(true, pattern.hasMatch(line));
          },
        ),
      );
    });
  });
}
