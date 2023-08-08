import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/nasa/route/nasa_route.dart';
import '../../route/home/home_route.dart';
import '../../space_data_explorer_app.dart';

Future<void> pumpNasaRouteAsInitialLocation(WidgetTester tester) async {
  await pumpApp(tester, initialLocation: NasaRoute.path);
}

Future<void> pumpNasaRouteAsNormalLink(WidgetTester tester) async {
  await pumpHomeRoute(tester);
  await tapNasaButton(tester);
}
