// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

// coverage:ignore-file

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingsState _$$_SettingsStateFromJson(Map<String, dynamic> json) =>
    _$_SettingsState(
      language: $enumDecode(_$LanguageEnumMap, json['language']),
      dateFormatPattern: json['dateFormatPattern'] as String,
      isAnyDialogShown: json['isAnyDialogShown'] as bool?,
    );

Map<String, dynamic> _$$_SettingsStateToJson(_$_SettingsState instance) =>
    <String, dynamic>{
      'language': _$LanguageEnumMap[instance.language]!,
      'dateFormatPattern': instance.dateFormatPattern,
      'isAnyDialogShown': instance.isAnyDialogShown,
    };

const _$LanguageEnumMap = {
  Language.english: 'en',
  Language.hindi: 'hi',
  Language.marathi: 'mr',
};
