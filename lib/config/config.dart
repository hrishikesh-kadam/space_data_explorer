// coverage:ignore-file
// ignore_for_file: directives_ordering

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:go_router/go_router.dart';
import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../constants/constants.dart';
import '../coverage_ignored.dart';
import '../extension/go_router.dart';
import '../globals.dart';
import '../helper/helper.dart';
import '../route/home/home_route.dart';
import 'app_bloc_observer.dart';
import 'firebase/firebase.dart';

import 'package:hrk_batteries/hrk_batteries.dart'
    hide kReleaseMode, kProfileMode;
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
      options.release = '$appNameKebabCase@${Constants.version}';
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
  await configureFirebaseProducts();
}

Future<void> configureFirebaseProducts() async {
  if (firebaseSupported) {
    await configureFirebase();
  }
  if (firebaseAnalyticsSupported) {
    configureFirebaseAnalytics();
  }
  if (crashlyticsSupported) {
    configureCrashlytics();
  }
}

BackButton getAppBarBackButton({
  required BuildContext context,
}) {
  return BackButton(
    onPressed: () {
      late final Object? extraObject;
      try {
        // throws expected AssertionError for errorBuilder widgets
        extraObject = GoRouterState.of(context).extra;
      } catch (_) {
        extraObject = null;
      }
      Level logLevel = flutterTest ? Level.FINER : Level.SHOUT;
      if (extraObject == null) {
        GoRouter.of(context).topOrHomeRoute();
      } else if (extraObject is JsonMap) {
        JsonMap extraMap = extraObject;
        if (extraMap.containsKey(isNormalLink)) {
          GoRouter.of(context).popOrHomeRoute();
        } else {
          logger.log(
              logLevel, 'getAppBarBackButton -> Unusual navigation observed');
          logger.log(logLevel, 'extra doesn\'t contains isNormalLink key');
          final routeMatchList = getListOfRouteMatch(context);
          logger.log(
              logLevel, 'routeMatchList.length = ${routeMatchList.length}');
          GoRouter.of(context).go(HomeRoute.uri.path);
        }
      } else {
        logger.log(
            logLevel, 'getAppBarBackButton -> Unusual navigation observed');
        logger.log(logLevel, 'extra is not a JsonMap');
        final routeMatchList = getListOfRouteMatch(context);
        logger.log(
            logLevel, 'routeMatchList.length = ${routeMatchList.length}');
        GoRouter.of(context).go(HomeRoute.uri.path);
      }
    },
  );
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
  if (pubspec == null) {
    pubspec = Pubspec.parse(await rootBundle.loadString('pubspec.yaml'));
    assert(Constants.appName == pubspec!.name);
    assert(Constants.version == pubspec!.version.toString());
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

final bool prodRelease = flavorEnv == FlavorEnv.prod && kReleaseMode;

String getPreReleaseVersion() {
  if (prodRelease) {
    return '';
  } else {
    return '${flavorEnv.name}-${getBuildMode()}';
  }
}

// LABEL: eligible-hrk_batteries
String getBuildMode() {
  if (kReleaseMode) {
    return 'release';
  } else if (kProfileMode) {
    return 'profile';
  } else {
    return 'debug';
  }
}

String getCompleteVersion() {
  final String version = pubspec!.version.toString();
  final String preReleaseVersion = getPreReleaseVersion();
  final String completeVersion =
      preReleaseVersion.isEmpty ? version : '$version-$preReleaseVersion';
  return completeVersion;
}

Uri getWebAppUrl() {
  final envSuffix = switch (flavorEnv) {
    FlavorEnv.dev || FlavorEnv.stag => '-${flavorEnv.name}',
    _ => '',
  };
  final domain = '$appNameKebabCase$envSuffix';
  const tld = 'web.app';
  return Uri.https('$domain.$tld');
}

final Uri webAppUrl = getWebAppUrl();
