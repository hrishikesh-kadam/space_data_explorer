import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/about/about_route.dart';
import 'package:space_data_explorer/route/about/about_screen.dart';
import 'package:space_data_explorer/widgets/app_bar.dart';
import '../../space_data_explorer_app.dart';
import '../home/home_route.dart';

final aboutActionFinder = find.byKey(aboutActionKey);
final scaffoldFinder = find.byKey(AboutScreen.scaffoldKey);
final actionsListViewFinder = find.byKey(AboutScreen.listViewKey);
final licenseButtonFinder = find.byKey(AboutScreen.licenseButtonKey);
final linktreeUriFinder = find.byKey(AboutScreen.linktreeUriKey);
final sourceUriFinder = find.byKey(AboutScreen.sourceUriKey);
final googlePlayStoreBadgeFinder =
    find.byKey(AboutScreen.googlePlayStoreBadgeKey);
final appleAppStoreBadgeFinder = find.byKey(AboutScreen.appleAppStoreBadgeKey);
final webAppUriFinder = find.byKey(AboutScreen.webAppUriKey);
final lastItemFinder = licenseButtonFinder;

Future<void> pumpAboutRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: AboutRoute.uri.path);
}

Future<void> pumpAboutRouteAsNormalLink(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  await pumpHomeRoute(tester, navigatorKey: navigatorKey);
  await tapAboutAction(tester);
}

Future<void> dragUntilLastItemVisible(WidgetTester tester) async {
  await tester.dragUntilVisible(
    lastItemFinder,
    actionsListViewFinder,
    const Offset(0, -200),
  );
  await tester.pumpAndSettle();
}

Future<void> tapAboutAction(WidgetTester tester) async {
  await tester.tap(aboutActionFinder);
  await tester.pumpAndSettle();
}

Future<void> tapLicenseButton(WidgetTester tester) async {
  await tester.tap(licenseButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> tapLinktreeUri(WidgetTester tester) async {
  await tester.tap(linktreeUriFinder);
  await tester.pumpAndSettle();
}

Future<void> tapSourceUri(WidgetTester tester) async {
  await tester.tap(sourceUriFinder);
  await tester.pumpAndSettle();
}

Future<void> tapGooglePlayStoreBadge(WidgetTester tester) async {
  await tester.tap(googlePlayStoreBadgeFinder);
  await tester.pumpAndSettle();
}

Future<void> tapAppleAppStoreBadge(WidgetTester tester) async {
  await tester.tap(appleAppStoreBadgeFinder);
  await tester.pumpAndSettle();
}

Future<void> tapWebAppUri(WidgetTester tester) async {
  await tester.tap(webAppUriFinder);
  await tester.pumpAndSettle();
}
