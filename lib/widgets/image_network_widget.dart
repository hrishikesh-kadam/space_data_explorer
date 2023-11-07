// coverage:ignore-file

import 'package:flutter/material.dart';

import '../globals.dart';

Widget getImageNetworkWidget(
  String src, {
  double? width,
  double? height,
}) {
  if (flutterTest && !flutterIntegrationTest) {
    return SizedBox(
      width: width,
      height: height,
      child: const Placeholder(),
    );
  } else {
    // coverage:ignore-start
    return Image.network(
      src,
      width: width,
      height: height,
    );
  } // coverage:ignore-end
}
