import 'package:flutter/material.dart';

import 'config/configure_app.dart';
import 'pages/home_page.dart';
import 'space_data_explorer.dart';

void main({
  String initialLocation = HomePage.path,
}) {
  configureApp();
  runApp(SpaceDataExplorerApp(
    initialLocation: initialLocation,
  ));
}
