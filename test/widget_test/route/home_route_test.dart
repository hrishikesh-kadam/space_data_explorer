import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_route.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../integration_test/home_route_test.dart';

void main() {
  group('$HomeRoute Widget Test', () {
    testWidgets('$HomeRoute', (WidgetTester tester) async {
      await pumpHomeRoute(tester);
    });

    testWidgets('Navigate $HomeRoute to $NasaRoute to $HomeRoute',
        (WidgetTester tester) async {
      await pumpHomeRoute(tester);
      final nasaTextButton =
          find.widgetWithText(TextButton, NasaRoute.relativePath);
      await tester.tap(nasaTextButton);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      final nasaScreenBackButton = find.byType(BackButton);
      await tester.tap(nasaScreenBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
