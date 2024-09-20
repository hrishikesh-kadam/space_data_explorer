// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  return _SettingsState.fromJson(json);
}

/// @nodoc
mixin _$SettingsState {
  @ThemeDataJsonConverter()
  ThemeData? get themeData => throw _privateConstructorUsedError;
  @LocaleJsonConverter()
  Locale? get locale => throw _privateConstructorUsedError;
  @LocaleListJsonConverter()
  List<Locale>? get systemLocales =>
      throw _privateConstructorUsedError; // @Default(LocaleExt.en) is used just to avoid nullability
  @LocaleJsonConverter2()
  Locale get resolvedLocale => throw _privateConstructorUsedError;
  DateFormatPattern get dateFormatPattern => throw _privateConstructorUsedError;
  TimeFormatPattern get timeFormatPattern => throw _privateConstructorUsedError;
  TextDirection? get textDirection => throw _privateConstructorUsedError;
  DistanceUnit get distanceUnit => throw _privateConstructorUsedError;
  VelocityUnit get velocityUnit => throw _privateConstructorUsedError;
  DistanceUnit get diameterUnit => throw _privateConstructorUsedError;
  bool? get isAnyDialogShown => throw _privateConstructorUsedError;

  /// Serializes this SettingsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call(
      {@ThemeDataJsonConverter() ThemeData? themeData,
      @LocaleJsonConverter() Locale? locale,
      @LocaleListJsonConverter() List<Locale>? systemLocales,
      @LocaleJsonConverter2() Locale resolvedLocale,
      DateFormatPattern dateFormatPattern,
      TimeFormatPattern timeFormatPattern,
      TextDirection? textDirection,
      DistanceUnit distanceUnit,
      VelocityUnit velocityUnit,
      DistanceUnit diameterUnit,
      bool? isAnyDialogShown});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeData = freezed,
    Object? locale = freezed,
    Object? systemLocales = freezed,
    Object? resolvedLocale = null,
    Object? dateFormatPattern = null,
    Object? timeFormatPattern = null,
    Object? textDirection = freezed,
    Object? distanceUnit = null,
    Object? velocityUnit = null,
    Object? diameterUnit = null,
    Object? isAnyDialogShown = freezed,
  }) {
    return _then(_value.copyWith(
      themeData: freezed == themeData
          ? _value.themeData
          : themeData // ignore: cast_nullable_to_non_nullable
              as ThemeData?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      systemLocales: freezed == systemLocales
          ? _value.systemLocales
          : systemLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>?,
      resolvedLocale: null == resolvedLocale
          ? _value.resolvedLocale
          : resolvedLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      dateFormatPattern: null == dateFormatPattern
          ? _value.dateFormatPattern
          : dateFormatPattern // ignore: cast_nullable_to_non_nullable
              as DateFormatPattern,
      timeFormatPattern: null == timeFormatPattern
          ? _value.timeFormatPattern
          : timeFormatPattern // ignore: cast_nullable_to_non_nullable
              as TimeFormatPattern,
      textDirection: freezed == textDirection
          ? _value.textDirection
          : textDirection // ignore: cast_nullable_to_non_nullable
              as TextDirection?,
      distanceUnit: null == distanceUnit
          ? _value.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
      velocityUnit: null == velocityUnit
          ? _value.velocityUnit
          : velocityUnit // ignore: cast_nullable_to_non_nullable
              as VelocityUnit,
      diameterUnit: null == diameterUnit
          ? _value.diameterUnit
          : diameterUnit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
      isAnyDialogShown: freezed == isAnyDialogShown
          ? _value.isAnyDialogShown
          : isAnyDialogShown // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
          _$SettingsStateImpl value, $Res Function(_$SettingsStateImpl) then) =
      __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ThemeDataJsonConverter() ThemeData? themeData,
      @LocaleJsonConverter() Locale? locale,
      @LocaleListJsonConverter() List<Locale>? systemLocales,
      @LocaleJsonConverter2() Locale resolvedLocale,
      DateFormatPattern dateFormatPattern,
      TimeFormatPattern timeFormatPattern,
      TextDirection? textDirection,
      DistanceUnit distanceUnit,
      VelocityUnit velocityUnit,
      DistanceUnit diameterUnit,
      bool? isAnyDialogShown});
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
      _$SettingsStateImpl _value, $Res Function(_$SettingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeData = freezed,
    Object? locale = freezed,
    Object? systemLocales = freezed,
    Object? resolvedLocale = null,
    Object? dateFormatPattern = null,
    Object? timeFormatPattern = null,
    Object? textDirection = freezed,
    Object? distanceUnit = null,
    Object? velocityUnit = null,
    Object? diameterUnit = null,
    Object? isAnyDialogShown = freezed,
  }) {
    return _then(_$SettingsStateImpl(
      themeData: freezed == themeData
          ? _value.themeData
          : themeData // ignore: cast_nullable_to_non_nullable
              as ThemeData?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale?,
      systemLocales: freezed == systemLocales
          ? _value._systemLocales
          : systemLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>?,
      resolvedLocale: null == resolvedLocale
          ? _value.resolvedLocale
          : resolvedLocale // ignore: cast_nullable_to_non_nullable
              as Locale,
      dateFormatPattern: null == dateFormatPattern
          ? _value.dateFormatPattern
          : dateFormatPattern // ignore: cast_nullable_to_non_nullable
              as DateFormatPattern,
      timeFormatPattern: null == timeFormatPattern
          ? _value.timeFormatPattern
          : timeFormatPattern // ignore: cast_nullable_to_non_nullable
              as TimeFormatPattern,
      textDirection: freezed == textDirection
          ? _value.textDirection
          : textDirection // ignore: cast_nullable_to_non_nullable
              as TextDirection?,
      distanceUnit: null == distanceUnit
          ? _value.distanceUnit
          : distanceUnit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
      velocityUnit: null == velocityUnit
          ? _value.velocityUnit
          : velocityUnit // ignore: cast_nullable_to_non_nullable
              as VelocityUnit,
      diameterUnit: null == diameterUnit
          ? _value.diameterUnit
          : diameterUnit // ignore: cast_nullable_to_non_nullable
              as DistanceUnit,
      isAnyDialogShown: freezed == isAnyDialogShown
          ? _value.isAnyDialogShown
          : isAnyDialogShown // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SettingsStateImpl extends _SettingsState {
  const _$SettingsStateImpl(
      {@ThemeDataJsonConverter() this.themeData,
      @LocaleJsonConverter() this.locale = SettingsState.localeDefault,
      @LocaleListJsonConverter() final List<Locale>? systemLocales,
      @LocaleJsonConverter2() this.resolvedLocale = LocaleExt.en,
      this.dateFormatPattern = SettingsState.dateFormatPatternDefault,
      this.timeFormatPattern = SettingsState.timeFormatPatternDefault,
      this.textDirection = SettingsState.textDirectionDefault,
      this.distanceUnit = SettingsState.distanceUnitDefault,
      this.velocityUnit = SettingsState.velocityUnitDefault,
      this.diameterUnit = SettingsState.diameterUnitDefault,
      this.isAnyDialogShown})
      : _systemLocales = systemLocales,
        super._();

  factory _$SettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsStateImplFromJson(json);

  @override
  @ThemeDataJsonConverter()
  final ThemeData? themeData;
  @override
  @JsonKey()
  @LocaleJsonConverter()
  final Locale? locale;
  final List<Locale>? _systemLocales;
  @override
  @LocaleListJsonConverter()
  List<Locale>? get systemLocales {
    final value = _systemLocales;
    if (value == null) return null;
    if (_systemLocales is EqualUnmodifiableListView) return _systemLocales;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// @Default(LocaleExt.en) is used just to avoid nullability
  @override
  @JsonKey()
  @LocaleJsonConverter2()
  final Locale resolvedLocale;
  @override
  @JsonKey()
  final DateFormatPattern dateFormatPattern;
  @override
  @JsonKey()
  final TimeFormatPattern timeFormatPattern;
  @override
  @JsonKey()
  final TextDirection? textDirection;
  @override
  @JsonKey()
  final DistanceUnit distanceUnit;
  @override
  @JsonKey()
  final VelocityUnit velocityUnit;
  @override
  @JsonKey()
  final DistanceUnit diameterUnit;
  @override
  final bool? isAnyDialogShown;

  @override
  String toString() {
    return 'SettingsState(themeData: $themeData, locale: $locale, systemLocales: $systemLocales, resolvedLocale: $resolvedLocale, dateFormatPattern: $dateFormatPattern, timeFormatPattern: $timeFormatPattern, textDirection: $textDirection, distanceUnit: $distanceUnit, velocityUnit: $velocityUnit, diameterUnit: $diameterUnit, isAnyDialogShown: $isAnyDialogShown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.themeData, themeData) ||
                other.themeData == themeData) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality()
                .equals(other._systemLocales, _systemLocales) &&
            (identical(other.resolvedLocale, resolvedLocale) ||
                other.resolvedLocale == resolvedLocale) &&
            (identical(other.dateFormatPattern, dateFormatPattern) ||
                other.dateFormatPattern == dateFormatPattern) &&
            (identical(other.timeFormatPattern, timeFormatPattern) ||
                other.timeFormatPattern == timeFormatPattern) &&
            (identical(other.textDirection, textDirection) ||
                other.textDirection == textDirection) &&
            (identical(other.distanceUnit, distanceUnit) ||
                other.distanceUnit == distanceUnit) &&
            (identical(other.velocityUnit, velocityUnit) ||
                other.velocityUnit == velocityUnit) &&
            (identical(other.diameterUnit, diameterUnit) ||
                other.diameterUnit == diameterUnit) &&
            (identical(other.isAnyDialogShown, isAnyDialogShown) ||
                other.isAnyDialogShown == isAnyDialogShown));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeData,
      locale,
      const DeepCollectionEquality().hash(_systemLocales),
      resolvedLocale,
      dateFormatPattern,
      timeFormatPattern,
      textDirection,
      distanceUnit,
      velocityUnit,
      diameterUnit,
      isAnyDialogShown);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsStateImplToJson(
      this,
    );
  }
}

abstract class _SettingsState extends SettingsState {
  const factory _SettingsState(
      {@ThemeDataJsonConverter() final ThemeData? themeData,
      @LocaleJsonConverter() final Locale? locale,
      @LocaleListJsonConverter() final List<Locale>? systemLocales,
      @LocaleJsonConverter2() final Locale resolvedLocale,
      final DateFormatPattern dateFormatPattern,
      final TimeFormatPattern timeFormatPattern,
      final TextDirection? textDirection,
      final DistanceUnit distanceUnit,
      final VelocityUnit velocityUnit,
      final DistanceUnit diameterUnit,
      final bool? isAnyDialogShown}) = _$SettingsStateImpl;
  const _SettingsState._() : super._();

  factory _SettingsState.fromJson(Map<String, dynamic> json) =
      _$SettingsStateImpl.fromJson;

  @override
  @ThemeDataJsonConverter()
  ThemeData? get themeData;
  @override
  @LocaleJsonConverter()
  Locale? get locale;
  @override
  @LocaleListJsonConverter()
  List<Locale>?
      get systemLocales; // @Default(LocaleExt.en) is used just to avoid nullability
  @override
  @LocaleJsonConverter2()
  Locale get resolvedLocale;
  @override
  DateFormatPattern get dateFormatPattern;
  @override
  TimeFormatPattern get timeFormatPattern;
  @override
  TextDirection? get textDirection;
  @override
  DistanceUnit get distanceUnit;
  @override
  VelocityUnit get velocityUnit;
  @override
  DistanceUnit get diameterUnit;
  @override
  bool? get isAnyDialogShown;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
