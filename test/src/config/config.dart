// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';

import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_logging/hrk_logging.dart';

import 'package:space_data_explorer/config/config.dart';
import 'package:space_data_explorer/config/firebase/firebase.dart';
import 'firebase.dart';
import 'hydrated_bloc.dart';

Future<void> configureApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadPubspec();
  configureUrlStrategy();
  configureHrkLogging();
  configureBloc();
  mockHydratedBloc();
  await configureFirebaseProducts();
}

Future<void> configureFirebaseProducts() async {
  if (firebaseSupported) {
    setupFirebaseCoreMocks();
    await configureFirebase();
  }
  if (firebaseAnalyticsSupported) {
    setupFirebaseAnalyticsMocks();
    configureFirebaseAnalytics();
  }
}
