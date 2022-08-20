// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 's_bloc_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SBlocStateTearOff {
  const _$SBlocStateTearOff();

  BlocInitial<S> init<S>() {
    return BlocInitial<S>();
  }

  BlocLoading<S> loading<S>() {
    return BlocLoading<S>();
  }

  BlocSuccess<S> success<S>({required S? data}) {
    return BlocSuccess<S>(
      data: data,
    );
  }

  BlocError<S> error<S>(dynamic error) {
    return BlocError<S>(
      error,
    );
  }
}

/// @nodoc
const $SBlocState = _$SBlocStateTearOff();

/// @nodoc
mixin _$SBlocState<S> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(S? data) success,
    required TResult Function(dynamic error) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlocInitial<S> value) init,
    required TResult Function(BlocLoading<S> value) loading,
    required TResult Function(BlocSuccess<S> value) success,
    required TResult Function(BlocError<S> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SBlocStateCopyWith<S, $Res> {
  factory $SBlocStateCopyWith(
          SBlocState<S> value, $Res Function(SBlocState<S>) then) =
      _$SBlocStateCopyWithImpl<S, $Res>;
}

/// @nodoc
class _$SBlocStateCopyWithImpl<S, $Res>
    implements $SBlocStateCopyWith<S, $Res> {
  _$SBlocStateCopyWithImpl(this._value, this._then);

  final SBlocState<S> _value;
  // ignore: unused_field
  final $Res Function(SBlocState<S>) _then;
}

/// @nodoc
abstract class $BlocInitialCopyWith<S, $Res> {
  factory $BlocInitialCopyWith(
          BlocInitial<S> value, $Res Function(BlocInitial<S>) then) =
      _$BlocInitialCopyWithImpl<S, $Res>;
}

/// @nodoc
class _$BlocInitialCopyWithImpl<S, $Res>
    extends _$SBlocStateCopyWithImpl<S, $Res>
    implements $BlocInitialCopyWith<S, $Res> {
  _$BlocInitialCopyWithImpl(
      BlocInitial<S> _value, $Res Function(BlocInitial<S>) _then)
      : super(_value, (v) => _then(v as BlocInitial<S>));

  @override
  BlocInitial<S> get _value => super._value as BlocInitial<S>;
}

/// @nodoc

class _$BlocInitial<S> implements BlocInitial<S> {
  const _$BlocInitial();

  @override
  String toString() {
    return 'SBlocState<$S>.init()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BlocInitial<S>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(S? data) success,
    required TResult Function(dynamic error) error,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlocInitial<S> value) init,
    required TResult Function(BlocLoading<S> value) loading,
    required TResult Function(BlocSuccess<S> value) success,
    required TResult Function(BlocError<S> value) error,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class BlocInitial<S> implements SBlocState<S> {
  const factory BlocInitial() = _$BlocInitial<S>;
}

/// @nodoc
abstract class $BlocLoadingCopyWith<S, $Res> {
  factory $BlocLoadingCopyWith(
          BlocLoading<S> value, $Res Function(BlocLoading<S>) then) =
      _$BlocLoadingCopyWithImpl<S, $Res>;
}

/// @nodoc
class _$BlocLoadingCopyWithImpl<S, $Res>
    extends _$SBlocStateCopyWithImpl<S, $Res>
    implements $BlocLoadingCopyWith<S, $Res> {
  _$BlocLoadingCopyWithImpl(
      BlocLoading<S> _value, $Res Function(BlocLoading<S>) _then)
      : super(_value, (v) => _then(v as BlocLoading<S>));

  @override
  BlocLoading<S> get _value => super._value as BlocLoading<S>;
}

/// @nodoc

class _$BlocLoading<S> implements BlocLoading<S> {
  const _$BlocLoading();

  @override
  String toString() {
    return 'SBlocState<$S>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is BlocLoading<S>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(S? data) success,
    required TResult Function(dynamic error) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlocInitial<S> value) init,
    required TResult Function(BlocLoading<S> value) loading,
    required TResult Function(BlocSuccess<S> value) success,
    required TResult Function(BlocError<S> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BlocLoading<S> implements SBlocState<S> {
  const factory BlocLoading() = _$BlocLoading<S>;
}

/// @nodoc
abstract class $BlocSuccessCopyWith<S, $Res> {
  factory $BlocSuccessCopyWith(
          BlocSuccess<S> value, $Res Function(BlocSuccess<S>) then) =
      _$BlocSuccessCopyWithImpl<S, $Res>;
  $Res call({S? data});
}

/// @nodoc
class _$BlocSuccessCopyWithImpl<S, $Res>
    extends _$SBlocStateCopyWithImpl<S, $Res>
    implements $BlocSuccessCopyWith<S, $Res> {
  _$BlocSuccessCopyWithImpl(
      BlocSuccess<S> _value, $Res Function(BlocSuccess<S>) _then)
      : super(_value, (v) => _then(v as BlocSuccess<S>));

  @override
  BlocSuccess<S> get _value => super._value as BlocSuccess<S>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(BlocSuccess<S>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as S?,
    ));
  }
}

/// @nodoc

class _$BlocSuccess<S> implements BlocSuccess<S> {
  const _$BlocSuccess({required this.data});

  @override
  final S? data;

  @override
  String toString() {
    return 'SBlocState<$S>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlocSuccess<S> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  $BlocSuccessCopyWith<S, BlocSuccess<S>> get copyWith =>
      _$BlocSuccessCopyWithImpl<S, BlocSuccess<S>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(S? data) success,
    required TResult Function(dynamic error) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlocInitial<S> value) init,
    required TResult Function(BlocLoading<S> value) loading,
    required TResult Function(BlocSuccess<S> value) success,
    required TResult Function(BlocError<S> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class BlocSuccess<S> implements SBlocState<S> {
  const factory BlocSuccess({required S? data}) = _$BlocSuccess<S>;

  S? get data;
  @JsonKey(ignore: true)
  $BlocSuccessCopyWith<S, BlocSuccess<S>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlocErrorCopyWith<S, $Res> {
  factory $BlocErrorCopyWith(
          BlocError<S> value, $Res Function(BlocError<S>) then) =
      _$BlocErrorCopyWithImpl<S, $Res>;
  $Res call({dynamic error});
}

/// @nodoc
class _$BlocErrorCopyWithImpl<S, $Res> extends _$SBlocStateCopyWithImpl<S, $Res>
    implements $BlocErrorCopyWith<S, $Res> {
  _$BlocErrorCopyWithImpl(
      BlocError<S> _value, $Res Function(BlocError<S>) _then)
      : super(_value, (v) => _then(v as BlocError<S>));

  @override
  BlocError<S> get _value => super._value as BlocError<S>;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(BlocError<S>(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$BlocError<S> implements BlocError<S> {
  const _$BlocError(this.error);

  @override
  final dynamic error;

  @override
  String toString() {
    return 'SBlocState<$S>.error(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BlocError<S> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  $BlocErrorCopyWith<S, BlocError<S>> get copyWith =>
      _$BlocErrorCopyWithImpl<S, BlocError<S>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() loading,
    required TResult Function(S? data) success,
    required TResult Function(dynamic error) error,
  }) {
    return error(this.error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
  }) {
    return error?.call(this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? loading,
    TResult Function(S? data)? success,
    TResult Function(dynamic error)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BlocInitial<S> value) init,
    required TResult Function(BlocLoading<S> value) loading,
    required TResult Function(BlocSuccess<S> value) success,
    required TResult Function(BlocError<S> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BlocInitial<S> value)? init,
    TResult Function(BlocLoading<S> value)? loading,
    TResult Function(BlocSuccess<S> value)? success,
    TResult Function(BlocError<S> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BlocError<S> implements SBlocState<S> {
  const factory BlocError(dynamic error) = _$BlocError<S>;

  dynamic get error;
  @JsonKey(ignore: true)
  $BlocErrorCopyWith<S, BlocError<S>> get copyWith =>
      throw _privateConstructorUsedError;
}
