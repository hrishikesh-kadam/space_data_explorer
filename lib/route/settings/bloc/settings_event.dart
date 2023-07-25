part of 'settings_bloc.dart';

sealed class SettingsEvent {
  const SettingsEvent();
}

class SettingsLaguageSelected extends SettingsEvent {
  const SettingsLaguageSelected({required this.language});

  final Language language;
}

class SettingsDateFormatSelected extends SettingsEvent {
  const SettingsDateFormatSelected({required this.dateFormatPattern});

  final DateFormatPattern dateFormatPattern;
}

class SettingsDialogEvent extends SettingsEvent {
  const SettingsDialogEvent({this.isAnyDialogShown});

  final bool? isAnyDialogShown;
}

class SettingsSystemLocalesChanged extends SettingsEvent {
  const SettingsSystemLocalesChanged({required this.systemLocales});

  final List<Locale>? systemLocales;
}
