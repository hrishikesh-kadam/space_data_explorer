import 'dart:async';

import 'package:logging/logging.dart';

import 'ansi_color.dart';
import 'emoji.dart';
import 'extensions/string.dart';
import 'globals.dart';
import 'level_debug.dart';

/// To maintain idempotency of the configureLogging()
StreamSubscription<LogRecord>? rootLoggerSubscription;

void configureHrkLogging() {
  if (rootLoggerSubscription != null) {
    return;
  }

  hierarchicalLoggingEnabled = true;
  Level level = kDebugMode ? Level.ALL : Level.INFO;
  Logger.root.level = dartOrFlutterTest ? Level.OFF : level;
  rootLoggerSubscription = Logger.root.onRecord.listen((record) {
    late final String color;
    late final String emoji;
    late final String emojiSpacer;
    late final String resetColor;
    if (record.level == Level.SHOUT) {
      emoji = Emoji.shout;
      color = AnsiColor.red;
    } else if (record.level == Level.SEVERE) {
      emoji = Emoji.severe;
      color = AnsiColor.red;
    } else if (record.level == Level.WARNING) {
      emoji = Emoji.warning;
      color = AnsiColor.yellow;
    } else if (record.level == Level.INFO) {
      emoji = Emoji.info;
      color = AnsiColor.green;
    } else if (record.level == HrkLevel.DEBUG) {
      emoji = Emoji.debug;
      color = AnsiColor.blue;
    } else {
      color = emoji = '';
    }
    emojiSpacer = emoji.isEmpty ? '' : ' ';
    resetColor = color.isEmpty ? '' : AnsiColor.reset;
    // ignore: avoid_print
    print(
      '${record.loggerName}: '
      '$color'
      '$emoji'
      '$emojiSpacer'
      '${record.level.name.capitalize()}: ${record.time}: ${record.message}'
      '$resetColor',
    );
  });
}
