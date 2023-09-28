import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:space_data_explorer/globals.dart';
import 'package:space_data_explorer/route/page_not_found/page_not_found_route.dart';
import '../../globals.dart';

Future<void> goNonExistingPath(
  WidgetTester tester,
) async {
  navigatorKey.currentContext!.go(
    PageNotFoundRoute.nonExistingPath,
    extra: getRouteExtraMap(),
  );
  await tester.pumpAndSettle();
}

Future<void> pushNonExistingPath(
  WidgetTester tester,
) async {
  navigatorKey.currentContext!.push(
    PageNotFoundRoute.nonExistingPath,
    extra: getRouteExtraMap(),
  );
  await tester.pumpAndSettle();
}
