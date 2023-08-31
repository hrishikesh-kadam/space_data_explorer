import 'package:flutter/material.dart';

import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/config/config.dart';
import 'hydrated_bloc.dart';

Future<void> configureApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadPubspec();
  configureUrlStrategy();
  configureHrkLogging();
  configureBloc();
  mockHydratedBloc();
}
