import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/cad_page.dart';
import 'package:space_data_explorer/nasa/cad/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_page.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/pages/home_page.dart';
import '../../../integration_test/nasa_page_test.dart';

void main() {
  group('$NasaPage Widget Test', () {
    testWidgets('Navigate $NasaPage to $CadPage to $NasaPage',
        (WidgetTester tester) async {
      await pumpNasaPageAsInitialLocation(tester);
      final cadTextButton = find.widgetWithText(TextButton, CadPage.pageName);
      await tester.tap(cadTextButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen, skipOffstage: false), findsOneWidget);
      expect(find.byType(CadScreen), findsOneWidget);
      final cadPageBackButton = find.byType(BackButton);
      await tester.tap(cadPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('$NasaPage', (WidgetTester tester) async {
      await pumpNasaPageAsInitialLocation(tester);
    });

    testWidgets('Navigate back from $NasaPage', (WidgetTester tester) async {
      await pumpNasaPageAsNormalLink(tester);
      final nasaPageBackButton = find.byType(BackButton);
      await tester.tap(nasaPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NasaScreen), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
