import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_route.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_route.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/route/home/home_screen.dart';
import '../../../integration_test/nasa_route_test.dart';

void main() {
  group('$NasaRoute Widget Test', () {
    testWidgets('Navigate $NasaRoute to $CadRoute to $NasaRoute',
        (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
      final cadTextButton =
          find.widgetWithText(TextButton, CadRoute.relativePath);
      await tester.tap(cadTextButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      final cadScreenBackButton = find.byType(BackButton);
      await tester.tap(cadScreenBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('$NasaRoute', (WidgetTester tester) async {
      await pumpNasaRouteAsInitialLocation(tester);
    });

    testWidgets('Navigate back from $NasaRoute', (WidgetTester tester) async {
      await pumpNasaRouteAsNormalLink(tester);
      final nasaScreenBackButton = find.byType(BackButton);
      await tester.tap(nasaScreenBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
