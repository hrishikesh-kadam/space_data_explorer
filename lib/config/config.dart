import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import '../extensions/string.dart';
import '../globals.dart';

import 'config_non_web.dart' if (dart.library.html) 'configure_web.dart'
    as platform;

void configureApp() {
  configureUrlStrategy();
  configureLogging();
}

AppBar getPlatformSpecificAppBar({
  required BuildContext context,
  Widget? title,
  PreferredSizeWidget? bottom,
}) {
  return platform.getPlatformSpecificAppBar(
    context: context,
    title: title,
    bottom: bottom,
  );
}

void configureUrlStrategy() {
  platform.configureUrlStrategy();
}

// ignore: constant_identifier_names
const Level DEBUG = Level('DEBUG', 600);

extension HrkLogger on Logger {
  void debug(Object? message, [Object? error, StackTrace? stackTrace]) =>
      this.log(DEBUG, message, error, stackTrace);
}

// To maintain idempotency of the configureLogging()
// Otherwise if called twice or more, log are printed that many times
StreamSubscription<LogRecord>? rootLoggerSubscription;

const String shoutEmoji = '😱';
const String severeEmoji = '🚫';
const String warningEmoji = '🚧';
const String infoEmoji = '📗';
const String debugEmoji = '🐛';

// Source - https://github.com/flutter/flutter/blob/master/packages/flutter_tools/lib/src/base/terminal.dart
const String redAnsiColor = '\u001b[31m';
const String greenAnsiColor = '\u001b[32m';
const String yellowAnsiColor = '\u001b[33m';
const String blueAnsiColor = '\u001b[34m';
const String resetAnsiColor = '\u001B[39m';

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
      emoji = shoutEmoji;
      color = redAnsiColor;
    } else if (record.level == Level.SEVERE) {
      emoji = severeEmoji;
      color = redAnsiColor;
    } else if (record.level == Level.WARNING) {
      emoji = warningEmoji;
      color = yellowAnsiColor;
    } else if (record.level == Level.INFO) {
      emoji = infoEmoji;
      color = greenAnsiColor;
    } else if (record.level == DEBUG) {
      emoji = debugEmoji;
      color = blueAnsiColor;
    } else {
      color = emoji = '';
    }
    emojiSpacer = emoji.isEmpty ? '' : ' ';
    resetColor = color.isEmpty ? '' : resetAnsiColor;
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
