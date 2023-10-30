import 'package:flutter/material.dart';

class NameThemeExtension extends ThemeExtension<NameThemeExtension> {
  const NameThemeExtension({
    required this.name,
    this.displayName,
  });

  final String name;
  final String? displayName;

  @override
  NameThemeExtension copyWith({
    String? name,
    String? displayName,
  }) {
    return NameThemeExtension(
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
    );
  }

  @override
  NameThemeExtension lerp(
    covariant ThemeExtension<NameThemeExtension>? other,
    double t,
  ) =>
      this;
}
