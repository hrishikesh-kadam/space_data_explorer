// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

// coverage:ignore-file

part of 'settings_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SettingsState _$$_SettingsStateFromJson(Map<String, dynamic> json) =>
    _$_SettingsState(
      locale: const LocaleJsonConverter()
          .fromJson(json['locale'] as Map<String, dynamic>?),
      systemLocales: const LocaleListJsonConverter()
          .fromJson(json['systemLocales'] as List?),
      dateFormatPattern: $enumDecodeNullable(
              _$DateFormatPatternEnumMap, json['dateFormatPattern']) ??
          DateFormatPattern.yMd,
      timeFormatPattern: $enumDecodeNullable(
              _$TimeFormatPatternEnumMap, json['timeFormatPattern']) ??
          TimeFormatPattern.jm,
      distanceUnit: json['distanceUnit'] == null
          ? DistanceUnit.au
          : DistanceUnit.fromJson(json['distanceUnit'] as Map<String, dynamic>),
      textDirection:
          $enumDecodeNullable(_$TextDirectionEnumMap, json['textDirection']),
      isAnyDialogShown: json['isAnyDialogShown'] as bool?,
    );

Map<String, dynamic> _$$_SettingsStateToJson(_$_SettingsState instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('locale', const LocaleJsonConverter().toJson(instance.locale));
  writeNotNull('systemLocales',
      const LocaleListJsonConverter().toJson(instance.systemLocales));
  val['dateFormatPattern'] =
      _$DateFormatPatternEnumMap[instance.dateFormatPattern]!;
  val['timeFormatPattern'] =
      _$TimeFormatPatternEnumMap[instance.timeFormatPattern]!;
  val['distanceUnit'] = instance.distanceUnit.toJson();
  writeNotNull('textDirection', _$TextDirectionEnumMap[instance.textDirection]);
  writeNotNull('isAnyDialogShown', instance.isAnyDialogShown);
  return val;
}

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

const _$TimeFormatPatternEnumMap = {
  TimeFormatPattern.jm: 'jm',
  TimeFormatPattern.twelveHourClock: 'h:mm a',
  TimeFormatPattern.twentyFourHourClock: 'HH:mm',
};

const _$TextDirectionEnumMap = {
  TextDirection.rtl: 'rtl',
  TextDirection.ltr: 'ltr',
};
