// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../language/language.dart';
import '../date_format_pattern.dart';
import 'settings_state.dart';

part 'settings_event.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required Language language,
    required DateFormatPattern dateFormatPattern,
  }) : super(SettingsState(
          language: language,
          dateFormatPattern: dateFormatPattern,
        )) {
    on<SettingsLaguageSelected>(_onLanguageSettingsChanged);
    on<SettingsDateFormatSelected>(_onSettingsDateFormatSelected);
    on<SettingsDialogEvent>(_onSettingsDialogEvent);
    on<SettingsSystemLocalesChanged>(_onSettingsSystemLocalesChanged);
  }

  static SettingsBloc getInitialSettings() {
    return SettingsBloc(
      language: Language.system,
      dateFormatPattern: DateFormatPattern.yMd,
    );
  }

  void _onLanguageSettingsChanged(
    SettingsLaguageSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      language: event.language,
      isAnyDialogShown: false,
    ));
  }

  void _onSettingsDateFormatSelected(
    SettingsDateFormatSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      dateFormatPattern: event.dateFormatPattern,
      isAnyDialogShown: false,
    ));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();

  void _onSettingsDialogEvent(
    SettingsDialogEvent event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      isAnyDialogShown: event.isAnyDialogShown,
    ));
  }

  void _onSettingsSystemLocalesChanged(
    SettingsSystemLocalesChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      systemLocales: event.systemLocales,
    ));
  }
}
