import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app_bloc_observer.dart';

// ignore: directives_ordering
import 'config_non_web.dart' if (dart.library.html) 'config_web.dart'
    as platform;

// coverage:ignore-start
Future<void> configureApp() async {
  configureUrlStrategy();
  configureHrkLogging();
  configureBloc();
  await configureHydratedBloc();
}
// coverage:ignore-end

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

// coverage:ignore-start
Future<void> configureHydratedBloc() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
}
// coverage:ignore-end
