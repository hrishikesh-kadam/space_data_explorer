import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/config/config.dart';

import 'hydrated_bloc.dart';

void configureApp() {
  configureUrlStrategy();
  configureHrkLogging();
  mockHydratedBloc();
}
