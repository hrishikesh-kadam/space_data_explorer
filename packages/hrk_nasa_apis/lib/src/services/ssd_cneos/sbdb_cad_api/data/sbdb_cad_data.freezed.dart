// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sbdb_cad_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SbdbCadData _$SbdbCadDataFromJson(Map<String, dynamic> json) {
  return _SbdbCadData.fromJson(json);
}

/// @nodoc
mixin _$SbdbCadData {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SbdbCadDataCopyWith<$Res> {
  factory $SbdbCadDataCopyWith(
          SbdbCadData value, $Res Function(SbdbCadData) then) =
      _$SbdbCadDataCopyWithImpl<$Res, SbdbCadData>;
}

/// @nodoc
class _$SbdbCadDataCopyWithImpl<$Res, $Val extends SbdbCadData>
    implements $SbdbCadDataCopyWith<$Res> {
  _$SbdbCadDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_SbdbCadDataCopyWith<$Res> {
  factory _$$_SbdbCadDataCopyWith(
          _$_SbdbCadData value, $Res Function(_$_SbdbCadData) then) =
      __$$_SbdbCadDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SbdbCadDataCopyWithImpl<$Res>
    extends _$SbdbCadDataCopyWithImpl<$Res, _$_SbdbCadData>
    implements _$$_SbdbCadDataCopyWith<$Res> {
  __$$_SbdbCadDataCopyWithImpl(
      _$_SbdbCadData _value, $Res Function(_$_SbdbCadData) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_SbdbCadData implements _SbdbCadData {
  _$_SbdbCadData();

  factory _$_SbdbCadData.fromJson(Map<String, dynamic> json) =>
      _$$_SbdbCadDataFromJson(json);

  @override
  String toString() {
    return 'SbdbCadData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SbdbCadData);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$_SbdbCadDataToJson(
      this,
    );
  }
}

abstract class _SbdbCadData implements SbdbCadData {
  factory _SbdbCadData() = _$_SbdbCadData;

  factory _SbdbCadData.fromJson(Map<String, dynamic> json) =
      _$_SbdbCadData.fromJson;
}
