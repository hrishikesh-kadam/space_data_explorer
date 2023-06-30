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
    case 'two00':
      return SbdbCad200Response.fromJson(json);
    case 'four00':
      return SbdbCad400Response.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SbdbCadResponse',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SbdbCadResponse {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Signature signature, int count) two00,
    required TResult Function(String message, String moreInfo, String code)
        four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count)? two00,
    TResult? Function(String message, String moreInfo, String code)? four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count)? two00,
    TResult Function(String message, String moreInfo, String code)? four00,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad200Response value) two00,
    required TResult Function(SbdbCad400Response value) four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad200Response value)? two00,
    TResult? Function(SbdbCad400Response value)? four00,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad200Response value)? two00,
    TResult Function(SbdbCad400Response value)? four00,
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
abstract class _$$SbdbCad200ResponseCopyWith<$Res> {
  factory _$$SbdbCad200ResponseCopyWith(_$SbdbCad200Response value,
          $Res Function(_$SbdbCad200Response) then) =
      __$$SbdbCad200ResponseCopyWithImpl<$Res>;
  @useResult
  $Res call({Signature signature, int count});

  $SignatureCopyWith<$Res> get signature;
}

/// @nodoc
class __$$SbdbCad200ResponseCopyWithImpl<$Res>
    extends _$SbdbCadResponseCopyWithImpl<$Res, _$SbdbCad200Response>
    implements _$$SbdbCad200ResponseCopyWith<$Res> {
  __$$SbdbCad200ResponseCopyWithImpl(
      _$SbdbCad200Response _value, $Res Function(_$SbdbCad200Response) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signature = null,
    Object? count = null,
  }) {
    return _then(_$SbdbCad200Response(
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
class _$SbdbCad200Response implements SbdbCad200Response {
  _$SbdbCad200Response(this.signature, this.count, {final String? $type})
      : $type = $type ?? 'two00';

  factory _$SbdbCad200Response.fromJson(Map<String, dynamic> json) =>
      _$$SbdbCad200ResponseFromJson(json);

  @override
  final Signature signature;
  @override
  final int count;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SbdbCadResponse.two00(signature: $signature, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SbdbCad200Response &&
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
  _$$SbdbCad200ResponseCopyWith<_$SbdbCad200Response> get copyWith =>
      __$$SbdbCad200ResponseCopyWithImpl<_$SbdbCad200Response>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Signature signature, int count) two00,
    required TResult Function(String message, String moreInfo, String code)
        four00,
  }) {
    return two00(signature, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count)? two00,
    TResult? Function(String message, String moreInfo, String code)? four00,
  }) {
    return two00?.call(signature, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count)? two00,
    TResult Function(String message, String moreInfo, String code)? four00,
    required TResult orElse(),
  }) {
    if (two00 != null) {
      return two00(signature, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad200Response value) two00,
    required TResult Function(SbdbCad400Response value) four00,
  }) {
    return two00(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad200Response value)? two00,
    TResult? Function(SbdbCad400Response value)? four00,
  }) {
    return two00?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad200Response value)? two00,
    TResult Function(SbdbCad400Response value)? four00,
    required TResult orElse(),
  }) {
    if (two00 != null) {
      return two00(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SbdbCad200ResponseToJson(
      this,
    );
  }
}

abstract class SbdbCad200Response implements SbdbCadResponse {
  factory SbdbCad200Response(final Signature signature, final int count) =
      _$SbdbCad200Response;

  factory SbdbCad200Response.fromJson(Map<String, dynamic> json) =
      _$SbdbCad200Response.fromJson;

  Signature get signature;
  int get count;
  @JsonKey(ignore: true)
  _$$SbdbCad200ResponseCopyWith<_$SbdbCad200Response> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SbdbCad400ResponseCopyWith<$Res> {
  factory _$$SbdbCad400ResponseCopyWith(_$SbdbCad400Response value,
          $Res Function(_$SbdbCad400Response) then) =
      __$$SbdbCad400ResponseCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, String moreInfo, String code});
}

/// @nodoc
class __$$SbdbCad400ResponseCopyWithImpl<$Res>
    extends _$SbdbCadResponseCopyWithImpl<$Res, _$SbdbCad400Response>
    implements _$$SbdbCad400ResponseCopyWith<$Res> {
  __$$SbdbCad400ResponseCopyWithImpl(
      _$SbdbCad400Response _value, $Res Function(_$SbdbCad400Response) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? moreInfo = null,
    Object? code = null,
  }) {
    return _then(_$SbdbCad400Response(
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
class _$SbdbCad400Response implements SbdbCad400Response {
  _$SbdbCad400Response(this.message, this.moreInfo, this.code,
      {final String? $type})
      : $type = $type ?? 'four00';

  factory _$SbdbCad400Response.fromJson(Map<String, dynamic> json) =>
      _$$SbdbCad400ResponseFromJson(json);

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
    return 'SbdbCadResponse.four00(message: $message, moreInfo: $moreInfo, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SbdbCad400Response &&
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
  _$$SbdbCad400ResponseCopyWith<_$SbdbCad400Response> get copyWith =>
      __$$SbdbCad400ResponseCopyWithImpl<_$SbdbCad400Response>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Signature signature, int count) two00,
    required TResult Function(String message, String moreInfo, String code)
        four00,
  }) {
    return four00(message, moreInfo, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Signature signature, int count)? two00,
    TResult? Function(String message, String moreInfo, String code)? four00,
  }) {
    return four00?.call(message, moreInfo, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Signature signature, int count)? two00,
    TResult Function(String message, String moreInfo, String code)? four00,
    required TResult orElse(),
  }) {
    if (four00 != null) {
      return four00(message, moreInfo, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SbdbCad200Response value) two00,
    required TResult Function(SbdbCad400Response value) four00,
  }) {
    return four00(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SbdbCad200Response value)? two00,
    TResult? Function(SbdbCad400Response value)? four00,
  }) {
    return four00?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SbdbCad200Response value)? two00,
    TResult Function(SbdbCad400Response value)? four00,
    required TResult orElse(),
  }) {
    if (four00 != null) {
      return four00(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SbdbCad400ResponseToJson(
      this,
    );
  }
}

abstract class SbdbCad400Response implements SbdbCadResponse {
  factory SbdbCad400Response(
          final String message, final String moreInfo, final String code) =
      _$SbdbCad400Response;

  factory SbdbCad400Response.fromJson(Map<String, dynamic> json) =
      _$SbdbCad400Response.fromJson;

  String get message;
  String get moreInfo;
  String get code;
  @JsonKey(ignore: true)
  _$$SbdbCad400ResponseCopyWith<_$SbdbCad400Response> get copyWith =>
      throw _privateConstructorUsedError;
}
