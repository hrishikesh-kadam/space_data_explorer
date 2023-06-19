import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/pages/nasa_source/nasa_source_screen.dart';
import 'package:space_data_explorer/pages/nasa_source/neows_screen.dart';
import '../../../integration_test/neows_page_test.dart';

void main() {
  group('NeowsPage Widget Test', () {
    testWidgets('Navigate back from NeowsPage', (WidgetTester tester) async {
      await pumpNeowsPageAsNormalLink(tester);
      final neowsPageBackButton = find.byType(BackButton);
      await tester.tap(neowsPageBackButton);
      await tester.pumpAndSettle();
      expect(find.byType(NeowsScreen), findsNothing);
      expect(find.byType(NasaSourceScreen), findsOneWidget);
    });

    testWidgets('NeowsPage', (WidgetTester tester) async {
      await pumpNeowsPageAsInitialLocation(tester);
    });
  });
}
