// GENERATED CODE - DO NOT MODIFY BY HAND

// coverage:ignore-file

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingsState _$$_SettingsStateFromJson(Map<String, dynamic> json) =>
    _$_SettingsState(
      language: $enumDecode(_$LanguageEnumMap, json['language']),
      dateFormat: const DateFormatJsonConverter()
          .fromJson(json['dateFormat'] as String?),
    );

Map<String, dynamic> _$$_SettingsStateToJson(_$_SettingsState instance) =>
    <String, dynamic>{
      'language': _$LanguageEnumMap[instance.language]!,
      'dateFormat': const DateFormatJsonConverter().toJson(instance.dateFormat),
    };

const _$LanguageEnumMap = {
  Language.english: 'en',
  Language.hindi: 'hi',
  Language.marathi: 'mr',
};
