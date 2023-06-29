// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sbdb_cad_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SbdbCadResponse _$SbdbCadResponseFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'twoxx':
      return SbdbCad2xxResponse.fromJson(json);
    case 'fourxx':
      return SbdbCad4xxResponse.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SbdbCadResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SbdbCadResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Signature signature, int count) twoxx,
    required TResult Function(String message, String moreInfo, String code)
        fourxx,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count)? twoxx,
    TResult? Function(String message, String moreInfo, String code)? fourxx,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count)? twoxx,
    TResult Function(String message, String moreInfo, String code)? fourxx,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad2xxResponse value) twoxx,
    required TResult Function(SbdbCad4xxResponse value) fourxx,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad2xxResponse value)? twoxx,
    TResult? Function(SbdbCad4xxResponse value)? fourxx,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad2xxResponse value)? twoxx,
    TResult Function(SbdbCad4xxResponse value)? fourxx,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SbdbCadResponseCopyWith<$Res> {
  factory $SbdbCadResponseCopyWith(
          SbdbCadResponse value, $Res Function(SbdbCadResponse) then) =
      _$SbdbCadResponseCopyWithImpl<$Res, SbdbCadResponse>;
}

/// @nodoc
class _$SbdbCadResponseCopyWithImpl<$Res, $Val extends SbdbCadResponse>
    implements $SbdbCadResponseCopyWith<$Res> {
  _$SbdbCadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SbdbCad2xxResponseCopyWith<$Res> {
  factory _$$SbdbCad2xxResponseCopyWith(_$SbdbCad2xxResponse value,
          $Res Function(_$SbdbCad2xxResponse) then) =
      __$$SbdbCad2xxResponseCopyWithImpl<$Res>;
  @useResult
  $Res call({Signature signature, int count});

  $SignatureCopyWith<$Res> get signature;
}

/// @nodoc
class __$$SbdbCad2xxResponseCopyWithImpl<$Res>
    extends _$SbdbCadResponseCopyWithImpl<$Res, _$SbdbCad2xxResponse>
    implements _$$SbdbCad2xxResponseCopyWith<$Res> {
  __$$SbdbCad2xxResponseCopyWithImpl(
      _$SbdbCad2xxResponse _value, $Res Function(_$SbdbCad2xxResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = null,
    Object? count = null,
  }) {
    return _then(_$SbdbCad2xxResponse(
      null == signature
          ? _value.signature
          : signature // ignore: cast_nullable_to_non_nullable
              as Signature,
      null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $SignatureCopyWith<$Res> get signature {
    return $SignatureCopyWith<$Res>(_value.signature, (value) {
      return _then(_value.copyWith(signature: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SbdbCad2xxResponse implements SbdbCad2xxResponse {
  _$SbdbCad2xxResponse(this.signature, this.count, {final String? $type})
      : $type = $type ?? 'twoxx';

  factory _$SbdbCad2xxResponse.fromJson(Map<String, dynamic> json) =>
      _$$SbdbCad2xxResponseFromJson(json);

  @override
  final Signature signature;
  @override
  final int count;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SbdbCadResponse.twoxx(signature: $signature, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SbdbCad2xxResponse &&
            (identical(other.signature, signature) ||
                other.signature == signature) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signature, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SbdbCad2xxResponseCopyWith<_$SbdbCad2xxResponse> get copyWith =>
      __$$SbdbCad2xxResponseCopyWithImpl<_$SbdbCad2xxResponse>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Signature signature, int count) twoxx,
    required TResult Function(String message, String moreInfo, String code)
        fourxx,
  }) {
    return twoxx(signature, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count)? twoxx,
    TResult? Function(String message, String moreInfo, String code)? fourxx,
  }) {
    return twoxx?.call(signature, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count)? twoxx,
    TResult Function(String message, String moreInfo, String code)? fourxx,
    required TResult orElse(),
  }) {
    if (twoxx != null) {
      return twoxx(signature, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad2xxResponse value) twoxx,
    required TResult Function(SbdbCad4xxResponse value) fourxx,
  }) {
    return twoxx(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad2xxResponse value)? twoxx,
    TResult? Function(SbdbCad4xxResponse value)? fourxx,
  }) {
    return twoxx?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad2xxResponse value)? twoxx,
    TResult Function(SbdbCad4xxResponse value)? fourxx,
    required TResult orElse(),
  }) {
    if (twoxx != null) {
      return twoxx(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SbdbCad2xxResponseToJson(
      this,
    );
  }
}

abstract class SbdbCad2xxResponse implements SbdbCadResponse {
  factory SbdbCad2xxResponse(final Signature signature, final int count) =
      _$SbdbCad2xxResponse;

  factory SbdbCad2xxResponse.fromJson(Map<String, dynamic> json) =
      _$SbdbCad2xxResponse.fromJson;

  Signature get signature;
  int get count;
  @JsonKey(ignore: true)
  _$$SbdbCad2xxResponseCopyWith<_$SbdbCad2xxResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SbdbCad4xxResponseCopyWith<$Res> {
  factory _$$SbdbCad4xxResponseCopyWith(_$SbdbCad4xxResponse value,
          $Res Function(_$SbdbCad4xxResponse) then) =
      __$$SbdbCad4xxResponseCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String moreInfo, String code});
}

/// @nodoc
class __$$SbdbCad4xxResponseCopyWithImpl<$Res>
    extends _$SbdbCadResponseCopyWithImpl<$Res, _$SbdbCad4xxResponse>
    implements _$$SbdbCad4xxResponseCopyWith<$Res> {
  __$$SbdbCad4xxResponseCopyWithImpl(
      _$SbdbCad4xxResponse _value, $Res Function(_$SbdbCad4xxResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? moreInfo = null,
    Object? code = null,
  }) {
    return _then(_$SbdbCad4xxResponse(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      null == moreInfo
          ? _value.moreInfo
          : moreInfo // ignore: cast_nullable_to_non_nullable
              as String,
      null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SbdbCad4xxResponse implements SbdbCad4xxResponse {
  _$SbdbCad4xxResponse(this.message, this.moreInfo, this.code,
      {final String? $type})
      : $type = $type ?? 'fourxx';

  factory _$SbdbCad4xxResponse.fromJson(Map<String, dynamic> json) =>
      _$$SbdbCad4xxResponseFromJson(json);

  @override
  final String message;
  @override
  final String moreInfo;
  @override
  final String code;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SbdbCadResponse.fourxx(message: $message, moreInfo: $moreInfo, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SbdbCad4xxResponse &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.moreInfo, moreInfo) ||
                other.moreInfo == moreInfo) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, moreInfo, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SbdbCad4xxResponseCopyWith<_$SbdbCad4xxResponse> get copyWith =>
      __$$SbdbCad4xxResponseCopyWithImpl<_$SbdbCad4xxResponse>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Signature signature, int count) twoxx,
    required TResult Function(String message, String moreInfo, String code)
        fourxx,
  }) {
    return fourxx(message, moreInfo, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count)? twoxx,
    TResult? Function(String message, String moreInfo, String code)? fourxx,
  }) {
    return fourxx?.call(message, moreInfo, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count)? twoxx,
    TResult Function(String message, String moreInfo, String code)? fourxx,
    required TResult orElse(),
  }) {
    if (fourxx != null) {
      return fourxx(message, moreInfo, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad2xxResponse value) twoxx,
    required TResult Function(SbdbCad4xxResponse value) fourxx,
  }) {
    return fourxx(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad2xxResponse value)? twoxx,
    TResult? Function(SbdbCad4xxResponse value)? fourxx,
  }) {
    return fourxx?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad2xxResponse value)? twoxx,
    TResult Function(SbdbCad4xxResponse value)? fourxx,
    required TResult orElse(),
  }) {
    if (fourxx != null) {
      return fourxx(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SbdbCad4xxResponseToJson(
      this,
    );
  }
}

abstract class SbdbCad4xxResponse implements SbdbCadResponse {
  factory SbdbCad4xxResponse(
          final String message, final String moreInfo, final String code) =
      _$SbdbCad4xxResponse;

  factory SbdbCad4xxResponse.fromJson(Map<String, dynamic> json) =
      _$SbdbCad4xxResponse.fromJson;

  String get message;
  String get moreInfo;
  String get code;
  @JsonKey(ignore: true)
  _$$SbdbCad4xxResponseCopyWith<_$SbdbCad4xxResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
