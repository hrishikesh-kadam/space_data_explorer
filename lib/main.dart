import 'package:flutter/material.dart';

import 'config/config.dart';
import 'space_data_explorer.dart';

Future<void> main({
  GlobalKey<NavigatorState>? navigatorKey,
  String? initialLocation,
  bool debugShowCheckedModeBanner = true,
}) async {
  await configureApp(
    appRunner: () => runApp(
      SpaceDataExplorerApp(
        navigatorKey: navigatorKey,
        initialLocation: initialLocation,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      ),
    ),
  );
}
