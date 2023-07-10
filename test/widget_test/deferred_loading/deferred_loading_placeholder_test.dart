import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/constants/localisation.dart';
import 'package:space_data_explorer/deferred_loading/deferred_loading.dart';

void main() {
  testWidgets('DeferredLoadingPlaceholder Widget Test',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: DeferredPlaceholderWidget(),
    ));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text(AppLocalisations.deferredTitle), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
