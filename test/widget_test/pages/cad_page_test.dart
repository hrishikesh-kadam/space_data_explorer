import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:space_data_explorer/nasa/cad_page.dart';

import 'package:space_data_explorer/nasa/cad_screen.dart';
import 'package:space_data_explorer/nasa/nasa_screen.dart';
import '../../../integration_test/cad_page_test.dart';

void main() {
  group('$CadPage Widget Test', () {
    testWidgets('Navigate back from $CadPage', (WidgetTester tester) async {
      await pumpCadPageAsNormalLink(tester);
      final cadPageBackButton = find.byType(BackButton);
      await tester.tap(cadPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(CadScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('$CadPage', (WidgetTester tester) async {
      await pumpCadPageAsInitialLocation(tester);
    });
  });
}
