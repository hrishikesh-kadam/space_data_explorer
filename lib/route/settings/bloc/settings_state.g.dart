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
      dateFormatPattern:
          $enumDecode(_$DateFormatPatternEnumMap, json['dateFormatPattern']),
      textDirection:
          $enumDecodeNullable(_$TextDirectionEnumMap, json['textDirection']),
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
  val['dateFormatPattern'] =
      _$DateFormatPatternEnumMap[instance.dateFormatPattern]!;
  writeNotNull('textDirection', _$TextDirectionEnumMap[instance.textDirection]);
  writeNotNull('isAnyDialogShown', instance.isAnyDialogShown);
  return val;
}

const _$LanguageEnumMap = {
  Language.system: 'system',
  Language.english: 'en',
  Language.hindi: 'hi',
  Language.marathi: 'mr',
};

const _$DateFormatPatternEnumMap = {
  DateFormatPattern.yMd: 'yMd',
  DateFormatPattern.ddMMyyyySlash: 'dd/MM/yyyy',
  DateFormatPattern.ddMMyyyyHyphen: 'dd-MM-yyyy',
  DateFormatPattern.MMddyyyySlash: 'MM/dd/yyyy',
  DateFormatPattern.MMddyyyyHyphen: 'MM-dd-yyyy',
  DateFormatPattern.yyyyMMddSlash: 'yyyy/MM/dd',
  DateFormatPattern.yyyyMMddHyphen: 'yyyy-MM-dd',
  DateFormatPattern.yyyyMMMddHyphen: 'yyyy-MMM-dd',
};

const _$TextDirectionEnumMap = {
  TextDirection.rtl: 'rtl',
  TextDirection.ltr: 'ltr',
};
