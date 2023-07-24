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
      systemLocales: const LocaleListJsonConverter()
          .fromJson(json['systemLocales'] as List?),
      dateFormatPattern: json['dateFormatPattern'] as String,
      isAnyDialogShown: json['isAnyDialogShown'] as bool?,
    );

Map<String, dynamic> _$$_SettingsStateToJson(_$_SettingsState instance) {
  final val = <String, dynamic>{
    'language': _$LanguageEnumMap[instance.language]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('systemLocales',
      const LocaleListJsonConverter().toJson(instance.systemLocales));
  val['dateFormatPattern'] = instance.dateFormatPattern;
  writeNotNull('isAnyDialogShown', instance.isAnyDialogShown);
  return val;
}

const _$LanguageEnumMap = {
  Language.system: 'system',
  Language.english: 'en',
  Language.hindi: 'hi',
  Language.marathi: 'mr',
};
