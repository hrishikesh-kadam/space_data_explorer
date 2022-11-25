import 'package:flutter/material.dart';

abstract class BasePage<T> extends MaterialPage<T> {
  const BasePage({
    required super.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    this.previousPage,
  });

  final BasePage? previousPage;

  @override
  bool operator ==(Object other) {
    return hashCode == other.hashCode;
  }

  @override
  int get hashCode => Object.hash(name, key, arguments, previousPage);
}
