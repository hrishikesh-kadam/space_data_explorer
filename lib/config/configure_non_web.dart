import 'package:flutter/material.dart';

AppBar getPlatformSpecificAppBar({
  required BuildContext context,
  Widget? title,
}) {
  return AppBar(
    title: title,
  );
}
