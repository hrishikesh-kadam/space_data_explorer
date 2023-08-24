import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/widgets/outlined_button_extended.dart';

void main() {
  group('$OutlinedButtonExtended Interaction Test', () {
    const key = Key('outlined_button_extended');
    final finder = find.byKey(key);

    testWidgets('loading', (tester) async {
      for (final networkState in [
        NetworkState.preparing,
        NetworkState.sending,
      ]) {
        await tester.pumpWidget(MaterialApp(
          home: OutlinedButtonExtended(
            key: key,
            label: const Text(''),
            networkState: networkState,
          ),
        ));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(finder.hitTestable().evaluate().length, 0);
      }
    });
  });
}
