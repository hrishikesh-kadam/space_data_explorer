// coverage:ignore-file

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../config/firebase/firebase.dart';

extension ReportLogger on Logger {
  void reportError(
    Object? message, {
    Object? error,
    StackTrace? stackTrace,
    Iterable<Object> information = const [],
    bool fatal = false,
  }) {
    log(HrkLevel.ERROR, message, error, stackTrace);
    if (crashlyticsSupported) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        reason: message,
        information: information,
        printDetails: false,
        fatal: fatal,
      );
    }
    Sentry.captureException(error, stackTrace: stackTrace);
  }
}
