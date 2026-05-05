// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FocusState {

 FocusStatus get status; int get totalMinutes; String? get sessionId; DateTime? get startedAt; DateTime? get pausedAt; int get pausedElapsed; String? get errorMessage;
/// Create a copy of FocusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FocusStateCopyWith<FocusState> get copyWith => _$FocusStateCopyWithImpl<FocusState>(this as FocusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FocusState&&(identical(other.status, status) || other.status == status)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.pausedElapsed, pausedElapsed) || other.pausedElapsed == pausedElapsed)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,totalMinutes,sessionId,startedAt,pausedAt,pausedElapsed,errorMessage);

@override
String toString() {
  return 'FocusState(status: $status, totalMinutes: $totalMinutes, sessionId: $sessionId, startedAt: $startedAt, pausedAt: $pausedAt, pausedElapsed: $pausedElapsed, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $FocusStateCopyWith<$Res>  {
  factory $FocusStateCopyWith(FocusState value, $Res Function(FocusState) _then) = _$FocusStateCopyWithImpl;
@useResult
$Res call({
 FocusStatus status, int totalMinutes, String? sessionId, DateTime? startedAt, DateTime? pausedAt, int pausedElapsed, String? errorMessage
});




}
/// @nodoc
class _$FocusStateCopyWithImpl<$Res>
    implements $FocusStateCopyWith<$Res> {
  _$FocusStateCopyWithImpl(this._self, this._then);

  final FocusState _self;
  final $Res Function(FocusState) _then;

/// Create a copy of FocusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? totalMinutes = null,Object? sessionId = freezed,Object? startedAt = freezed,Object? pausedAt = freezed,Object? pausedElapsed = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FocusStatus,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedElapsed: null == pausedElapsed ? _self.pausedElapsed : pausedElapsed // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FocusState].
extension FocusStatePatterns on FocusState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FocusState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FocusState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FocusState value)  $default,){
final _that = this;
switch (_that) {
case _FocusState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FocusState value)?  $default,){
final _that = this;
switch (_that) {
case _FocusState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FocusStatus status,  int totalMinutes,  String? sessionId,  DateTime? startedAt,  DateTime? pausedAt,  int pausedElapsed,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FocusState() when $default != null:
return $default(_that.status,_that.totalMinutes,_that.sessionId,_that.startedAt,_that.pausedAt,_that.pausedElapsed,_that.errorMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FocusStatus status,  int totalMinutes,  String? sessionId,  DateTime? startedAt,  DateTime? pausedAt,  int pausedElapsed,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _FocusState():
return $default(_that.status,_that.totalMinutes,_that.sessionId,_that.startedAt,_that.pausedAt,_that.pausedElapsed,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FocusStatus status,  int totalMinutes,  String? sessionId,  DateTime? startedAt,  DateTime? pausedAt,  int pausedElapsed,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _FocusState() when $default != null:
return $default(_that.status,_that.totalMinutes,_that.sessionId,_that.startedAt,_that.pausedAt,_that.pausedElapsed,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _FocusState implements FocusState {
  const _FocusState({this.status = FocusStatus.initial, this.totalMinutes = 25, this.sessionId, this.startedAt, this.pausedAt, this.pausedElapsed = 0, this.errorMessage});
  

@override@JsonKey() final  FocusStatus status;
@override@JsonKey() final  int totalMinutes;
@override final  String? sessionId;
@override final  DateTime? startedAt;
@override final  DateTime? pausedAt;
@override@JsonKey() final  int pausedElapsed;
@override final  String? errorMessage;

/// Create a copy of FocusState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FocusStateCopyWith<_FocusState> get copyWith => __$FocusStateCopyWithImpl<_FocusState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FocusState&&(identical(other.status, status) || other.status == status)&&(identical(other.totalMinutes, totalMinutes) || other.totalMinutes == totalMinutes)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.pausedElapsed, pausedElapsed) || other.pausedElapsed == pausedElapsed)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,totalMinutes,sessionId,startedAt,pausedAt,pausedElapsed,errorMessage);

@override
String toString() {
  return 'FocusState(status: $status, totalMinutes: $totalMinutes, sessionId: $sessionId, startedAt: $startedAt, pausedAt: $pausedAt, pausedElapsed: $pausedElapsed, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$FocusStateCopyWith<$Res> implements $FocusStateCopyWith<$Res> {
  factory _$FocusStateCopyWith(_FocusState value, $Res Function(_FocusState) _then) = __$FocusStateCopyWithImpl;
@override @useResult
$Res call({
 FocusStatus status, int totalMinutes, String? sessionId, DateTime? startedAt, DateTime? pausedAt, int pausedElapsed, String? errorMessage
});




}
/// @nodoc
class __$FocusStateCopyWithImpl<$Res>
    implements _$FocusStateCopyWith<$Res> {
  __$FocusStateCopyWithImpl(this._self, this._then);

  final _FocusState _self;
  final $Res Function(_FocusState) _then;

/// Create a copy of FocusState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? totalMinutes = null,Object? sessionId = freezed,Object? startedAt = freezed,Object? pausedAt = freezed,Object? pausedElapsed = null,Object? errorMessage = freezed,}) {
  return _then(_FocusState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FocusStatus,totalMinutes: null == totalMinutes ? _self.totalMinutes : totalMinutes // ignore: cast_nullable_to_non_nullable
as int,sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pausedElapsed: null == pausedElapsed ? _self.pausedElapsed : pausedElapsed // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
