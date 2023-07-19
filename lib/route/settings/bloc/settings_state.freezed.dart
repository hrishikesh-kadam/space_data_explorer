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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  return _SettingsState.fromJson(json);
}

/// @nodoc
mixin _$SettingsState {
  Language get language => throw _privateConstructorUsedError;
  @LocaleListJsonConverter()
  List<Locale>? get systemLocales => throw _privateConstructorUsedError;
  @LocaleListJsonConverter()
  set systemLocales(List<Locale>? value) => throw _privateConstructorUsedError;
  String get dateFormatPattern => throw _privateConstructorUsedError;
  bool? get isAnyDialogShown => throw _privateConstructorUsedError;
  set isAnyDialogShown(bool? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {Language language,
      @LocaleListJsonConverter() List<Locale>? systemLocales,
      String dateFormatPattern,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? systemLocales = freezed,
    Object? dateFormatPattern = null,
    Object? isAnyDialogShown = freezed,
  }) {
    return _then(_value.copyWith(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
      systemLocales: freezed == systemLocales
          ? _value.systemLocales
          : systemLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>?,
      dateFormatPattern: null == dateFormatPattern
          ? _value.dateFormatPattern
          : dateFormatPattern // ignore: cast_nullable_to_non_nullable
              as String,
      isAnyDialogShown: freezed == isAnyDialogShown
          ? _value.isAnyDialogShown
          : isAnyDialogShown // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SettingsStateCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$_SettingsStateCopyWith(
          _$_SettingsState value, $Res Function(_$_SettingsState) then) =
      __$$_SettingsStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Language language,
      @LocaleListJsonConverter() List<Locale>? systemLocales,
      String dateFormatPattern,
      bool? isAnyDialogShown});
}

/// @nodoc
class __$$_SettingsStateCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$_SettingsState>
    implements _$$_SettingsStateCopyWith<$Res> {
  __$$_SettingsStateCopyWithImpl(
      _$_SettingsState _value, $Res Function(_$_SettingsState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? systemLocales = freezed,
    Object? dateFormatPattern = null,
    Object? isAnyDialogShown = freezed,
  }) {
    return _then(_$_SettingsState(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
      systemLocales: freezed == systemLocales
          ? _value.systemLocales
          : systemLocales // ignore: cast_nullable_to_non_nullable
              as List<Locale>?,
      dateFormatPattern: null == dateFormatPattern
          ? _value.dateFormatPattern
          : dateFormatPattern // ignore: cast_nullable_to_non_nullable
              as String,
      isAnyDialogShown: freezed == isAnyDialogShown
          ? _value.isAnyDialogShown
          : isAnyDialogShown // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SettingsState implements _SettingsState {
  _$_SettingsState(
      {required this.language,
      @LocaleListJsonConverter() this.systemLocales,
      required this.dateFormatPattern,
      this.isAnyDialogShown});

  factory _$_SettingsState.fromJson(Map<String, dynamic> json) =>
      _$$_SettingsStateFromJson(json);

  @override
  final Language language;
  @override
  @LocaleListJsonConverter()
  List<Locale>? systemLocales;
  @override
  final String dateFormatPattern;
  @override
  bool? isAnyDialogShown;

  @override
  String toString() {
    return 'SettingsState(language: $language, systemLocales: $systemLocales, dateFormatPattern: $dateFormatPattern, isAnyDialogShown: $isAnyDialogShown)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SettingsStateCopyWith<_$_SettingsState> get copyWith =>
      __$$_SettingsStateCopyWithImpl<_$_SettingsState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingsStateToJson(
      this,
    );
  }
}

abstract class _SettingsState implements SettingsState {
  factory _SettingsState(
      {required final Language language,
      @LocaleListJsonConverter() List<Locale>? systemLocales,
      required final String dateFormatPattern,
      bool? isAnyDialogShown}) = _$_SettingsState;

  factory _SettingsState.fromJson(Map<String, dynamic> json) =
      _$_SettingsState.fromJson;

  @override
  Language get language;
  @override
  @LocaleListJsonConverter()
  List<Locale>? get systemLocales;
  @LocaleListJsonConverter()
  set systemLocales(List<Locale>? value);
  @override
  String get dateFormatPattern;
  @override
  bool? get isAnyDialogShown;
  set isAnyDialogShown(bool? value);
  @override
  @JsonKey(ignore: true)
  _$$_SettingsStateCopyWith<_$_SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}
