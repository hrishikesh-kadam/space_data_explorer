// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingsState _$$_SettingsStateFromJson(Map<String, dynamic> json) =>
    _$_SettingsState(
      language: $enumDecode(_$LanguageEnumMap, json['language']),
      dateFormatPattern: json['dateFormatPattern'] as String,
      isAnyDialogOpen: json['isAnyDialogOpen'] as bool?,
    );

Map<String, dynamic> _$$_SettingsStateToJson(_$_SettingsState instance) =>
    <String, dynamic>{
      'language': _$LanguageEnumMap[instance.language]!,
      'dateFormatPattern': instance.dateFormatPattern,
      'isAnyDialogOpen': instance.isAnyDialogOpen,
    };

const _$LanguageEnumMap = {
  Language.english: 'en',
  Language.hindi: 'hi',
  Language.marathi: 'mr',
};
