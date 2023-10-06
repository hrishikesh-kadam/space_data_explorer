import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';

import 'package:space_data_explorer/route/about/about_route.dart';
import 'package:space_data_explorer/route/about/about_screen.dart';
import 'package:space_data_explorer/route/home/home_route.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../src/route/about/about_route.dart';

void main() {
  group('$AboutRoute Navigation Test', () {
    testWidgets('Navigate $HomeRoute to $AboutRoute, press back',
        (tester) async {
      await pumpAboutRouteAsNormalLink(tester);
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(AboutScreen), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(AboutScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('As initialLocation', (WidgetTester tester) async {
      await pumpAboutRouteAsInitialLocation(tester);
      expect(find.byType(AboutScreen), findsOneWidget);
      expect(aboutActionFinder, findsNothing);
    });

    testWidgets('Navigate $AboutRoute to $LicensePage, press back',
        (tester) async {
      await pumpAboutRouteAsInitialLocation(tester);
      await tapLicenseButton(tester);
      expect(find.byType(AboutScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(LicensePage), findsOneWidget);
      await tapBackButton(tester);
      expect(find.byType(LicensePage), findsNothing);
      expect(find.byType(AboutScreen), findsOneWidget);
    });
  });
}
