// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cad_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CadState {
  DateTimeRange? get dateRange => throw _privateConstructorUsedError;
  NetworkState get networkState => throw _privateConstructorUsedError;
  SbdbCadBody? get sbdbCadBody => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CadStateCopyWith<CadState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CadStateCopyWith<$Res> {
  factory $CadStateCopyWith(CadState value, $Res Function(CadState) then) =
      _$CadStateCopyWithImpl<$Res, CadState>;
  @useResult
  $Res call(
      {DateTimeRange? dateRange,
      NetworkState networkState,
      SbdbCadBody? sbdbCadBody});

  $SbdbCadBodyCopyWith<$Res>? get sbdbCadBody;
}

/// @nodoc
class _$CadStateCopyWithImpl<$Res, $Val extends CadState>
    implements $CadStateCopyWith<$Res> {
  _$CadStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = freezed,
    Object? networkState = null,
    Object? sbdbCadBody = freezed,
  }) {
    return _then(_value.copyWith(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      networkState: null == networkState
          ? _value.networkState
          : networkState // ignore: cast_nullable_to_non_nullable
              as NetworkState,
      sbdbCadBody: freezed == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SbdbCadBodyCopyWith<$Res>? get sbdbCadBody {
    if (_value.sbdbCadBody == null) {
      return null;
    }

    return $SbdbCadBodyCopyWith<$Res>(_value.sbdbCadBody!, (value) {
      return _then(_value.copyWith(sbdbCadBody: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CadStateCopyWith<$Res> implements $CadStateCopyWith<$Res> {
  factory _$$_CadStateCopyWith(
          _$_CadState value, $Res Function(_$_CadState) then) =
      __$$_CadStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTimeRange? dateRange,
      NetworkState networkState,
      SbdbCadBody? sbdbCadBody});

  @override
  $SbdbCadBodyCopyWith<$Res>? get sbdbCadBody;
}

/// @nodoc
class __$$_CadStateCopyWithImpl<$Res>
    extends _$CadStateCopyWithImpl<$Res, _$_CadState>
    implements _$$_CadStateCopyWith<$Res> {
  __$$_CadStateCopyWithImpl(
      _$_CadState _value, $Res Function(_$_CadState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateRange = freezed,
    Object? networkState = null,
    Object? sbdbCadBody = freezed,
  }) {
    return _then(_$_CadState(
      dateRange: freezed == dateRange
          ? _value.dateRange
          : dateRange // ignore: cast_nullable_to_non_nullable
              as DateTimeRange?,
      networkState: null == networkState
          ? _value.networkState
          : networkState // ignore: cast_nullable_to_non_nullable
              as NetworkState,
      sbdbCadBody: freezed == sbdbCadBody
          ? _value.sbdbCadBody
          : sbdbCadBody // ignore: cast_nullable_to_non_nullable
              as SbdbCadBody?,
    ));
  }
}

/// @nodoc

class _$_CadState implements _CadState {
  _$_CadState(
      {this.dateRange,
      this.networkState = NetworkState.initial,
      this.sbdbCadBody});

  @override
  final DateTimeRange? dateRange;
  @override
  @JsonKey()
  final NetworkState networkState;
  @override
  final SbdbCadBody? sbdbCadBody;

  @override
  String toString() {
    return 'CadState(dateRange: $dateRange, networkState: $networkState, sbdbCadBody: $sbdbCadBody)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CadState &&
            (identical(other.dateRange, dateRange) ||
                other.dateRange == dateRange) &&
            (identical(other.networkState, networkState) ||
                other.networkState == networkState) &&
            (identical(other.sbdbCadBody, sbdbCadBody) ||
                other.sbdbCadBody == sbdbCadBody));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, dateRange, networkState, sbdbCadBody);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CadStateCopyWith<_$_CadState> get copyWith =>
      __$$_CadStateCopyWithImpl<_$_CadState>(this, _$identity);
}

abstract class _CadState implements CadState {
  factory _CadState(
      {final DateTimeRange? dateRange,
      final NetworkState networkState,
      final SbdbCadBody? sbdbCadBody}) = _$_CadState;

  @override
  DateTimeRange? get dateRange;
  @override
  NetworkState get networkState;
  @override
  SbdbCadBody? get sbdbCadBody;
  @override
  @JsonKey(ignore: true)
  _$$_CadStateCopyWith<_$_CadState> get copyWith =>
      throw _privateConstructorUsedError;
}