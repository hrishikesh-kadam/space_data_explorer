import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';

import '../../../language/language.dart';
import 'settings_state.dart';

part 'settings_event.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required Language language,
    required DateFormat dateFormat,
  }) : super(SettingsState(
          language: language,
          dateFormat: dateFormat,
        )) {
    on<SettingsLaguageSelected>(_onLanguageSettingsChanged);
  }

  void _onLanguageSettingsChanged(
    SettingsLaguageSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(language: event.language));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}
