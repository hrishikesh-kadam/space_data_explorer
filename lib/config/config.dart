// coverage:ignore-file
// ignore_for_file: directives_ordering

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../firebase/options/dev.dart' as firebase_dev;
import '../firebase/options/prod.dart' as firebase_prod;
import '../firebase/options/stag.dart' as firebase_stag;
import 'app_bloc_observer.dart';

import 'config_non_web.dart' if (dart.library.html) 'config_web.dart'
    as platform;

Future<void> configureApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureUrlStrategy();
  configureHrkLogging();
  configureBloc();
  await configureHydratedBloc();
  await configureFirebase();
  configureErrorReporting();
}

BackButton getAppBarBackButton({
  required BuildContext context,
}) {
  return platform.getAppBarBackButton(context: context);
}

void configureUrlStrategy() {
  platform.configureUrlStrategy();
}

void configureBloc() {
  Bloc.observer = const AppBlocObserver();
}

Future<void> configureHydratedBloc() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
}

// https://github.com/MisterJimson/flutter_keyboard_visibility
bool isKeyboardVisibilitySupported() {
  if (kIsWeb) {
    return false;
  } else {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android || TargetPlatform.iOS => true,
      _ => false
    };
  }
}

enum FlavorEnv {
  dev,
  stag,
  prod,
  unflavored;

  factory FlavorEnv.fromString(String flavor) {
    return switch (flavor) {
      'dev' => FlavorEnv.dev,
      'stag' => FlavorEnv.stag,
      'prod' => FlavorEnv.prod,
      '' => FlavorEnv.unflavored,
      _ => throw ArgumentError.value(flavor),
    };
  }
}

final FlavorEnv flavorEnv = FlavorEnv.fromString(
  const String.fromEnvironment('FLAVOR_ENV'),
);

Future<void> configureFirebase() async {
  final FirebaseOptions options = switch (flavorEnv) {
    FlavorEnv.dev => firebase_dev.DefaultFirebaseOptions.currentPlatform,
    FlavorEnv.stag => firebase_stag.DefaultFirebaseOptions.currentPlatform,
    FlavorEnv.prod => firebase_prod.DefaultFirebaseOptions.currentPlatform,
    _ => throw ArgumentError.value(flavorEnv),
  };
  await Firebase.initializeApp(
    options: options,
  );
}

void configureErrorReporting() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter
  // framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
