// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../date_format_pattern.dart';
import 'settings_state.dart';

part 'settings_event.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required DateFormatPattern dateFormatPattern,
  }) : super(SettingsState(
          dateFormatPattern: dateFormatPattern,
        )) {
    on<SettingsLocaleSelected>(_onSettingsLocaleChanged);
    on<SettingsDateFormatSelected>(_onSettingsDateFormatSelected);
    on<SettingsDialogEvent>(_onSettingsDialogEvent);
    on<SettingsSystemLocalesChanged>(_onSettingsSystemLocalesChanged);
    on<SettingsTextDirectionSelected>(_onSettingsTextDirectionSelected);
  }

  static SettingsBloc getInitialSettings() {
    return SettingsBloc(
      dateFormatPattern: DateFormatPattern.yMd,
    );
  }

  void _onSettingsLocaleChanged(
    SettingsLocaleSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      locale: event.locale,
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

  void _onSettingsTextDirectionSelected(
    SettingsTextDirectionSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(
      textDirection: event.textDirection,
    ));
  }
}
