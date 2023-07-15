import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../language/language.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({
    required this.language,
  }) : super(SettingsInitial(
          language: language,
        )) {
    on<SettingsLaguageSelected>(_onLanguageSettingsChanged);
  }

  Language language;

  void _onLanguageSettingsChanged(
    SettingsLaguageSelected event,
    Emitter<SettingsState> emit,
  ) {
    language = event.language;
    emit(SettingsLanguageChange(language: language));
  }
}
