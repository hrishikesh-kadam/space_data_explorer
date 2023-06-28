import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/nasa_screen.dart';
import 'package:space_data_explorer/nasa/neows_screen.dart';
import '../../../integration_test/neows_page_test.dart';

void main() {
  group('NeowsPage Widget Test', () {
    testWidgets('Navigate back from NeowsPage', (WidgetTester tester) async {
      await pumpNeowsPageAsNormalLink(tester);
      final neowsPageBackButton = find.byType(BackButton);
      await tester.tap(neowsPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaScreen), findsOneWidget);
    });

    testWidgets('NeowsPage', (WidgetTester tester) async {
      await pumpNeowsPageAsInitialLocation(tester);
    });
  });
}
