import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/nasa_page.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import '../../../integration_test/home_page_test.dart';

void main() {
  group('$HomePage Widget Test', () {
    testWidgets('$HomePage', (WidgetTester tester) async {
      await pumpHomePage(tester);
    });

    testWidgets('Navigate $HomePage to $NasaPage to $HomePage',
        (WidgetTester tester) async {
      await pumpHomePage(tester);
      final nasaTextButton =
          find.widgetWithText(TextButton, NasaPage.pageName);
      await tester.tap(nasaTextButton);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaScreen), findsOneWidget);
      final nasaPageBackButton = find.byType(BackButton);
      await tester.tap(nasaPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
