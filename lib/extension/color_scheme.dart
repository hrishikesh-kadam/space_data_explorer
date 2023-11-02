import 'package:flutter/material.dart';

import 'package:material_color_utilities/material_color_utilities.dart';

extension ColorSchemeExt on ColorScheme {
  Color get surfaceContainerHighest {
    final Hct surfaceHct = Hct.fromInt(surface.value);
    final Hct surfaceContainerHighestHct = Hct.from(
      surfaceHct.hue,
      surfaceHct.chroma,
      brightness == Brightness.light ? 90 : 22,
    );
    return Color(surfaceContainerHighestHct.toInt());
  }

  // For surface which contains brightness unaware contents like brand images
  Color get surfaceFixed {
    final Hct surfaceHct = Hct.fromInt(surface.value);
    final Hct surfaceFixedHct = Hct.from(
      surfaceHct.hue,
      surfaceHct.chroma,
      80,
    );
    return Color(surfaceFixedHct.toInt());
  }
}
