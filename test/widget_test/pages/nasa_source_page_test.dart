import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/nasa/neows_page.dart';
import 'package:space_data_explorer/nasa/neows_screen.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import '../../../integration_test/nasa_source_page_test.dart';

void main() {
  group('NasaSourcePage Widget Test', () {
    testWidgets('Navigate NasaSourcePage to NeowsPage to NasaSourcePage',
        (WidgetTester tester) async {
      await pumpNasaSourcePageAsInitialLocation(tester);
      final neowsTextButton =
          find.widgetWithText(TextButton, NeowsPage.pageName);
      await tester.tap(neowsTextButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(NeowsScreen), findsOneWidget);
      final neowsPageBackButton = find.byType(BackButton);
      await tester.tap(neowsPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('NasaSourcePage', (WidgetTester tester) async {
      await pumpNasaSourcePageAsInitialLocation(tester);
    });

    testWidgets('Navigate back from NasaSourcePage',
        (WidgetTester tester) async {
      await pumpNasaSourcePageAsNormalLink(tester);
      final nasaSourcePageBackButton = find.byType(BackButton);
      await tester.tap(nasaSourcePageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
