part of 'settings_bloc.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class SettingsThemeSelected extends SettingsEvent {
  const SettingsThemeSelected({required this.themeData});

  final ThemeData? themeData;
}

class SettingsLocaleSelected extends SettingsEvent {
  const SettingsLocaleSelected({required this.locale});

  final Locale? locale;
}

class SettingsSystemLocalesChanged extends SettingsEvent {
  const SettingsSystemLocalesChanged({required this.systemLocales});

  final List<Locale>? systemLocales;
}

class SettingsLocaleResolved extends SettingsEvent {
  const SettingsLocaleResolved({required this.resolvedLocale});

  final Locale resolvedLocale;
}

class SettingsDateFormatSelected extends SettingsEvent {
  const SettingsDateFormatSelected({required this.dateFormatPattern});

  final DateFormatPattern dateFormatPattern;
}

class SettingsTimeFormatSelected extends SettingsEvent {
  const SettingsTimeFormatSelected({required this.timeFormatPattern});

  final TimeFormatPattern timeFormatPattern;
}

class SettingsDialogEvent extends SettingsEvent {
  const SettingsDialogEvent({this.isAnyDialogShown});

  final bool? isAnyDialogShown;
}

class SettingsTextDirectionSelected extends SettingsEvent {
  const SettingsTextDirectionSelected({required this.textDirection});

  final TextDirection? textDirection;
}

class SettingsDistanceUnitSelected extends SettingsEvent {
  const SettingsDistanceUnitSelected({required this.distanceUnit});

  final DistanceUnit distanceUnit;
}

class SettingsVelocityUnitSelected extends SettingsEvent {
  const SettingsVelocityUnitSelected({required this.velocityUnit});

  final VelocityUnit velocityUnit;
}

class SettingsDiameterUnitSelected extends SettingsEvent {
  const SettingsDiameterUnitSelected({required this.diameterUnit});

  final DistanceUnit diameterUnit;
}
