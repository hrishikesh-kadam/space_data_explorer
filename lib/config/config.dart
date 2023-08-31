// coverage:ignore-file
// ignore_for_file: directives_ordering

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../constants/constants.dart';
import '../coverage_ignored.dart';
import 'app_bloc_observer.dart';
import 'firebase/firebase.dart';

import 'config_non_web.dart' if (dart.library.html) 'config_web.dart'
    as platform;

Future<void> configureApp({
  required AppRunner appRunner,
}) async {
  configureUrlStrategy();
  configureHrkLogging();
  configureBloc();
  await SentryFlutter.init(
    (options) async {
      options.dsn = kReleaseMode
          ? 'https://3656530f2f6bf1ad4f46db3ad3e152d7@o4505777435377664.ingest.sentry.io/4505783833001984'
          : '';
      options.tracesSampleRate = 1.0;
      options.environment = flavorEnv.name;
      options.release = '$appNameKebabCase@$version';
    },
    appRunner: () async {
      await configurePostBinding();
      await appRunner();
    },
  );
}

Future<void> configurePostBinding() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadPubspec();
  await configureHydratedBloc();
  if (isFirebaseSupported()) {
    await configureFirebase();
  }
  if (isFirebaseAnalyticsSupported()) {
    configureFirebaseAnalytics();
  }
  if (isCrashlyticsSupported()) {
    configureCrashlytics();
  }
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

Pubspec? pubspec;
Future<void> loadPubspec() async {
  if (pubspec != null) {
    pubspec = Pubspec.parse(await rootBundle.loadString('pubspec.yaml'));
    assert(appName == pubspec!.name);
    assert(version == pubspec!.version.toString());
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
