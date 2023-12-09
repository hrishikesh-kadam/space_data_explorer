// coverage:ignore-file
// ignore_for_file: directives_ordering

import 'package:flutter/foundation.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../config.dart';
import 'options/dev.dart' as firebase_dev;
import 'options/prod.dart' as firebase_prod;
import 'options/stag.dart' as firebase_stag;

// https://firebase.google.com/docs/flutter/setup?platform=flutter#available-plugins
// https://github.com/firebase/flutterfire/tree/master/packages/firebase_core/firebase_core
final bool firebaseSupported = isFirebaseSupported();
bool isFirebaseSupported() {
  if (kIsWeb) {
    return true;
  } else {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.macOS ||
      TargetPlatform.windows =>
        true,
      _ => false
    };
  }
}

Future<void> configureFirebase() async {
  final FirebaseOptions? options = switch (flavorEnv) {
    FlavorEnv.dev => firebase_dev.DefaultFirebaseOptions.currentPlatform,
    FlavorEnv.stag => firebase_stag.DefaultFirebaseOptions.currentPlatform,
    FlavorEnv.prod => firebase_prod.DefaultFirebaseOptions.currentPlatform,
    FlavorEnv.unflavored => null,
  };
  await Firebase.initializeApp(
    options: options,
  );
}

// https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics
final bool firebaseAnalyticsSupported = isFirebaseAnalyticsSupported();
bool isFirebaseAnalyticsSupported() {
  if (kIsWeb) {
    return true;
  } else {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.macOS =>
        true,
      _ => false
    };
  }
}

void configureFirebaseAnalytics() {
  if (!kReleaseMode) {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
  }
}

// https://github.com/firebase/flutterfire/tree/master/packages/firebase_crashlytics/firebase_crashlytics
final bool crashlyticsSupported = isCrashlyticsSupported();
bool isCrashlyticsSupported() {
  if (kIsWeb) {
    return false;
  } else {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android ||
      TargetPlatform.iOS ||
      TargetPlatform.macOS =>
        true,
      _ => false
    };
  }
}

void configureCrashlytics() {
  if (!kReleaseMode) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  final previousFlutterOnError = FlutterError.onError;
  FlutterError.onError = (details) {
    if (previousFlutterOnError != null &&
        previousFlutterOnError != FlutterError.presentError) {
      previousFlutterOnError(details);
    }
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  };
  final previousPlatformOnError = PlatformDispatcher.instance.onError;
  PlatformDispatcher.instance.onError = (exception, stackTrace) {
    if (previousPlatformOnError != null) {
      previousPlatformOnError(exception, stackTrace);
    }
    FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      fatal: true,
    );
    return true;
  };
}
