part of 'settings_bloc.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class SettingsLocaleSelected extends SettingsEvent {
  const SettingsLocaleSelected({required this.locale});

  final Locale? locale;
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

class SettingsSystemLocalesChanged extends SettingsEvent {
  const SettingsSystemLocalesChanged({required this.systemLocales});

  final List<Locale>? systemLocales;
}

class SettingsTextDirectionSelected extends SettingsEvent {
  const SettingsTextDirectionSelected({required this.textDirection});

  final TextDirection? textDirection;
}
