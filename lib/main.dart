import 'package:flutter/material.dart';

import 'config/configure_app.dart';
import 'space_data_explorer.dart';

void main({
  GlobalKey<NavigatorState>? navigatorKey,
  String? initialLocation,
  bool debugShowCheckedModeBanner = true,
}) {
  configureApp();
  runApp(SpaceDataExplorerApp(
    navigatorKey: navigatorKey,
    initialLocation: initialLocation,
    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
  ));
}
