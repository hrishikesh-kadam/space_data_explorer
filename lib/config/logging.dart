import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:logging/logging.dart';

import '../extensions/string.dart';
import '../globals.dart';

// ignore: constant_identifier_names
const Level DEBUG = Level('DEBUG', 600);

extension HrkLogger on Logger {
  void debug(Object? message, [Object? error, StackTrace? stackTrace]) =>
      this.log(DEBUG, message, error, stackTrace);
}

// To maintain idempotency of the configureLogging()
// Otherwise if called twice or more, log are printed that many times
StreamSubscription<LogRecord>? rootLoggerSubscription;

class Emoji {
  static const String shout = '😱';
  static const String severe = '🚫';
  static const String warning = '🚧';
  static const String info = '📗';
  static const String debug = '🐛';
}

// Source - https://github.com/flutter/flutter/blob/master/packages/flutter_tools/lib/src/base/terminal.dart
class AnsiColor {
  static const String red = '\u001b[31m';
  static const String green = '\u001b[32m';
  static const String yellow = '\u001b[33m';
  static const String blue = '\u001b[34m';
  static const String reset = '\u001B[39m';
}

void configureLogging() {
  if (rootLoggerSubscription != null) {
    return;
  }

  // Mandatory steps - https://pub.dev/packages/logging
  hierarchicalLoggingEnabled = true;
  Level level = kDebugMode ? Level.ALL : Level.INFO;
  Logger.root.level = flutterTest ? Level.OFF : level;
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
    } else if (record.level == DEBUG) {
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
