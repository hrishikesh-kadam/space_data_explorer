import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

Widget getImageWidget({
  required String assetName,
  String? semanticLabel,
  double? width,
  double? height,
}) {
  if (assetName.endsWith('svg')) {
    return SvgPicture.asset(
      assetName,
      semanticsLabel: semanticLabel,
      width: width,
      height: height,
    );
  } else {
    return Image.asset(
      assetName,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
    );
  }
}
