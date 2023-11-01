import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/cad/bloc/cad_state.dart';
import 'package:space_data_explorer/widgets/worker_button.dart';

void main() {
  group('$WorkerButton Interaction Test', () {
    const key = Key('worker_button');
    final finder = find.byKey(key);

    testWidgets('loading', (tester) async {
      for (final networkState in [
        NetworkState.preparing,
        NetworkState.sending,
      ]) {
        await tester.pumpWidget(MaterialApp(
          home: WorkerButton(
            key: key,
            label: const Text(''),
            networkState: networkState,
          ),
        ));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(finder.hitTestable().evaluate().length, 0);
      }
    });

    testWidgets('icon', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: WorkerButton(
          key: key,
          icon: CircularProgressIndicator(),
          label: Text(''),
          networkState: NetworkState.sending,
        ),
      ));
    });
  });
}
