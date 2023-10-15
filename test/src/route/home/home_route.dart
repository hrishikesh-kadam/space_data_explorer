import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../space_data_explorer_app.dart';

final orgGridFinder = find.byKey(HomeScreen.orgGridKey);
final orgItemFinder = find.descendant(
  of: orgGridFinder,
  matching: find.byKey(HomeScreen.orgItemContainerKey),
);
final nasaItemFinder = find.byKey(HomeScreen.nasaItemKey);
final isroItemFinder = find.byKey(HomeScreen.isroItemKey);
final esaItemFinder = find.byKey(HomeScreen.esaItemKey);
final isaItemFinder = find.byKey(HomeScreen.isaItemKey);
final kariItemFinder = find.byKey(HomeScreen.kariItemKey);
final spacexItemFinder = find.byKey(HomeScreen.spacexItemKey);
final jaxaItemFinder = find.byKey(HomeScreen.jaxaItemKey);

Future<void> pumpHomeRoute(
  WidgetTester tester, {
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  await pumpApp(tester, navigatorKey: navigatorKey);
}

Future<void> tapNasaItem(WidgetTester tester) async {
  await tester.tap(nasaItemFinder);
  await tester.pumpAndSettle();
}

Future<void> tapIsroItem(WidgetTester tester) async {
  await tester.tap(isroItemFinder);
  await tester.pumpAndSettle();
}

Future<void> tapEsaItem(WidgetTester tester) async {
  await tester.tap(esaItemFinder);
  await tester.pumpAndSettle();
}

Future<void> tapIsaItem(WidgetTester tester) async {
  await tester.tap(isaItemFinder);
  await tester.pumpAndSettle();
}

Future<void> tapKariItem(WidgetTester tester) async {
  await tester.tap(kariItemFinder);
  await tester.pumpAndSettle();
}

Future<void> tapSpacexItem(WidgetTester tester) async {
  await tester.tap(spacexItemFinder);
  await tester.pumpAndSettle();
}

Future<void> tapJaxaItem(WidgetTester tester) async {
  await tester.tap(jaxaItemFinder);
  await tester.pumpAndSettle();
}
