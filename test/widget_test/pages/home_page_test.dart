import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/pages/home_page.dart';
import 'package:space_data_explorer/pages/nasa_source/nasa_source_page.dart';
import 'package:space_data_explorer/pages/nasa_source/nasa_source_screen.dart';
import '../../../integration_test/home_page_test.dart';

void main() {
  group('HomePage Widget Test', () {
    testWidgets('HomePage', (WidgetTester tester) async {
      await pumpHomePage(tester);
    });

    testWidgets('Navigate HomePage to NasaSourcePage to HomePage',
        (WidgetTester tester) async {
      await pumpHomePage(tester);
      final nasaSourceTextButton =
          find.widgetWithText(TextButton, NasaSourcePage.pageName);
      await tester.tap(nasaSourceTextButton);
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NasaSourceScreen), findsOneWidget);
      final nasaSourcePageBackButton = find.byType(BackButton);
      await tester.tap(nasaSourcePageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaSourceScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
