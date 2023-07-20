import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/language/language.dart';
import 'package:space_data_explorer/route/settings/settings_route.dart';
import 'package:space_data_explorer/route/settings/settings_screen.dart';
import '../../../../../integration_test/globals.dart';
import '../../../../../integration_test/settings_route_helper.dart';

void main() {
  group('$SettingsRoute ${l10n.language} Tile Widget Test', () {
    testWidgets('Tap', (WidgetTester tester) async {
      await pumpSettingsRouteAsNormalLink(tester);
      await tester.tap(find.byKey(SettingsScreen.languageTileKey));
      await tester.pumpAndSettle();
      expect(find.byKey(SettingsScreen.languageDialogKey), findsOneWidget);
      await tester.tap(find.byKey(Key(Language.english.displayName!)));
      await tester.pumpAndSettle();
      expect(find.byKey(SettingsScreen.languageDialogKey), findsNothing);
    }, tags: 't1');
  });
}
