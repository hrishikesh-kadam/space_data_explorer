part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsLaguageSelected extends SettingsEvent {
  const SettingsLaguageSelected({required this.language});

  final Language language;

  @override
  List<Object> get props => [language];
}

class SettingsDateFormatSelected extends SettingsEvent {
  const SettingsDateFormatSelected({required this.dateFormatPattern});

  final String dateFormatPattern;

  @override
  List<Object> get props => [dateFormatPattern];
}

class SettingsDialogEvent extends SettingsEvent {
  const SettingsDialogEvent({this.isAnyDialogShown});

  final bool? isAnyDialogShown;
}
