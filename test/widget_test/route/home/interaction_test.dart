import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/home/home_route.dart';
import '../../../src/route/home/home_route.dart';

void main() {
  group('$HomeRoute Interaction Test', () {
    testWidgets('Tap all links', (WidgetTester tester) async {
      await pumpHomeRoute(tester);
      await tapIsroItem(tester);
      await tapEsaItem(tester);
      await tapIsaItem(tester);
      await tapKariItem(tester);
      await tapSpacexItem(tester);
      await tapJaxaItem(tester);
    });
  });
}
