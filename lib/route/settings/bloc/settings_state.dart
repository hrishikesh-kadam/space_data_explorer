part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  get language => null;
  get dateFormat => null;

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {
  const SettingsInitial({
    required this.language,
  });

  @override
  final Language language;

  @override
  List<Object> get props => [language];
}

class SettingsLanguageChange extends SettingsState {
  const SettingsLanguageChange({required this.language});

  @override
  final Language language;

  @override
  List<Object> get props => [language];
}
