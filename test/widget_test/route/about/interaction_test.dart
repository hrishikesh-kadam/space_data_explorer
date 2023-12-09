import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:space_data_explorer/route/about/about_route.dart';
import '../../../src/helper/helper.dart';
import '../../../src/route/about/about_route.dart';

void main() {
  group('$AboutRoute Interaction Test', () {
    testWidgets('Tap all links', (tester) async {
      await pumpAboutRouteAsInitialLocation(tester);
      await tapLinktreeUri(tester);
      await tapSourceUri(tester);
      await tapWebAppUri(tester);
    });

    testWidgets('Tap all links, iOS', (tester) async {
      await pumpAboutRouteAsInitialLocation(tester);
      await precacheAllImages(tester);
      await tapGooglePlayBadge(tester);
    }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));
  });
}
