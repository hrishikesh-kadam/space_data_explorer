import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../route/settings/bloc/settings_bloc.dart';
import '../route/settings/bloc/settings_state.dart';

// Notes:
// 1. Reason to not use Directionality before the MaterialApp is that, we are
// dependent on Flutter to resolve the Locale if null (that is when setting is
// system preferred). Once we ourself resolve the Locale then this can be moved
// above the MaterialApp.
Widget getDirectionality({required Widget child}) {
  return BlocBuilder<SettingsBloc, SettingsState>(
    buildWhen: (previous, current) {
      return previous.textDirection != current.textDirection ||
          previous.locale != current.locale;
    },
    builder: (context, settingsState) {
      late final TextDirection textDirection;
      if (settingsState.textDirection == null) {
        final languageTag = Localizations.localeOf(context).toLanguageTag();
        textDirection = Bidi.isRtlLanguage(languageTag)
            ? TextDirection.rtl
            : TextDirection.ltr;
      } else {
        textDirection = settingsState.textDirection!;
      }
      return Directionality(
        textDirection: textDirection,
        child: child,
      );
    },
  );
}
