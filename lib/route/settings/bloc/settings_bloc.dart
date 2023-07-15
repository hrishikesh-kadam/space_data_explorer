import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../language/language.dart';
import 'settings_state.dart';

part 'settings_event.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required Language language,
    required String dateFormatPattern,
  }) : super(SettingsState(
          language: language,
          dateFormatPattern: dateFormatPattern,
        )) {
    on<SettingsLaguageSelected>(_onLanguageSettingsChanged);
    on<SettingsDateFormatSelected>(_onSettingsDateFormatSelected);
  }

  void _onLanguageSettingsChanged(
    SettingsLaguageSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(language: event.language));
  }

  void _onSettingsDateFormatSelected(
    SettingsDateFormatSelected event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(dateFormatPattern: event.dateFormatPattern));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}
