import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../language/language.dart';

part 'settings_state.freezed.dart';
part 'settings_state.g.dart';

@unfreezed
class SettingsState with _$SettingsState {
  factory SettingsState({
    required final Language language,
    required final String dateFormatPattern,
    bool? isAnyDialogShown,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}
