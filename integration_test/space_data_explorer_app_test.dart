import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:space_data_explorer/route/home/home_screen.dart';
import 'package:space_data_explorer/space_data_explorer.dart';
import 'config.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('SpaceDataExplorerApp Integration Test',
      (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}

/*
 * TODO(hrishikesh-kadam): Check if the following issue is resolved.
 * https://github.com/flutter/flutter/issues/102469 
 */
Future<void> pumpApp(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
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
