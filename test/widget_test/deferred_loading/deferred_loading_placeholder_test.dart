import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/deferred_loading/deferred_loading.dart';

void main() {
  testWidgets('$DeferredPlaceholderWidget Widget Test',
      (WidgetTester tester) async {
    const String title = 'Loading... Please Wait!';
    await tester.pumpWidget(const MaterialApp(
      home: DeferredPlaceholderWidget(
        title: title,
      ),
    ));
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text(title), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
