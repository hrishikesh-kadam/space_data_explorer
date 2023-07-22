import 'package:flutter_test/flutter_test.dart';
import 'package:space_data_explorer/space_data_explorer.dart';

import 'config/config.dart';
import 'globals.dart';

/*
 * TODO(hrishikesh-kadam): Check if the following issue is resolved.
 * https://github.com/flutter/flutter/issues/102469 
 */
Future<void> pumpApp(
  WidgetTester tester, {
  String? initialLocation,
  bool debugShowCheckedModeBanner = true,
}) async {
  configureApp();
  await tester.pumpWidget(SpaceDataExplorerApp(
    navigatorKey: navigatorKey,
    initialLocation: initialLocation,
    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
  ));
  await tester.pumpAndSettle();
}
