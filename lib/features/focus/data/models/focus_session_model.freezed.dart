// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FocusSessionModel {

 String get id;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'task_id') String? get taskId;@JsonKey(name: 'duration_minutes') int get durationMinutes;@JsonKey(name: 'started_at') String get startedAt;@JsonKey(name: 'ended_at') String? get endedAt;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of FocusSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FocusSessionModelCopyWith<FocusSessionModel> get copyWith => _$FocusSessionModelCopyWithImpl<FocusSessionModel>(this as FocusSessionModel, _$identity);

  /// Serializes this FocusSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FocusSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,taskId,durationMinutes,startedAt,endedAt,createdAt);

@override
String toString() {
  return 'FocusSessionModel(id: $id, userId: $userId, taskId: $taskId, durationMinutes: $durationMinutes, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FocusSessionModelCopyWith<$Res>  {
  factory $FocusSessionModelCopyWith(FocusSessionModel value, $Res Function(FocusSessionModel) _then) = _$FocusSessionModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'task_id') String? taskId,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$FocusSessionModelCopyWithImpl<$Res>
    implements $FocusSessionModelCopyWith<$Res> {
  _$FocusSessionModelCopyWithImpl(this._self, this._then);

  final FocusSessionModel _self;
  final $Res Function(FocusSessionModel) _then;

/// Create a copy of FocusSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? taskId = freezed,Object? durationMinutes = null,Object? startedAt = null,Object? endedAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FocusSessionModel].
extension FocusSessionModelPatterns on FocusSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FocusSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FocusSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FocusSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _FocusSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FocusSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _FocusSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'task_id')  String? taskId, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FocusSessionModel() when $default != null:
return $default(_that.id,_that.userId,_that.taskId,_that.durationMinutes,_that.startedAt,_that.endedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'task_id')  String? taskId, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _FocusSessionModel():
return $default(_that.id,_that.userId,_that.taskId,_that.durationMinutes,_that.startedAt,_that.endedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'task_id')  String? taskId, @JsonKey(name: 'duration_minutes')  int durationMinutes, @JsonKey(name: 'started_at')  String startedAt, @JsonKey(name: 'ended_at')  String? endedAt, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FocusSessionModel() when $default != null:
return $default(_that.id,_that.userId,_that.taskId,_that.durationMinutes,_that.startedAt,_that.endedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FocusSessionModel extends FocusSessionModel {
  const _FocusSessionModel({required this.id, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'task_id') this.taskId, @JsonKey(name: 'duration_minutes') required this.durationMinutes, @JsonKey(name: 'started_at') required this.startedAt, @JsonKey(name: 'ended_at') this.endedAt, @JsonKey(name: 'created_at') required this.createdAt}): super._();
  factory _FocusSessionModel.fromJson(Map<String, dynamic> json) => _$FocusSessionModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'task_id') final  String? taskId;
@override@JsonKey(name: 'duration_minutes') final  int durationMinutes;
@override@JsonKey(name: 'started_at') final  String startedAt;
@override@JsonKey(name: 'ended_at') final  String? endedAt;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of FocusSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FocusSessionModelCopyWith<_FocusSessionModel> get copyWith => __$FocusSessionModelCopyWithImpl<_FocusSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FocusSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FocusSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,taskId,durationMinutes,startedAt,endedAt,createdAt);

@override
String toString() {
  return 'FocusSessionModel(id: $id, userId: $userId, taskId: $taskId, durationMinutes: $durationMinutes, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FocusSessionModelCopyWith<$Res> implements $FocusSessionModelCopyWith<$Res> {
  factory _$FocusSessionModelCopyWith(_FocusSessionModel value, $Res Function(_FocusSessionModel) _then) = __$FocusSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'task_id') String? taskId,@JsonKey(name: 'duration_minutes') int durationMinutes,@JsonKey(name: 'started_at') String startedAt,@JsonKey(name: 'ended_at') String? endedAt,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$FocusSessionModelCopyWithImpl<$Res>
    implements _$FocusSessionModelCopyWith<$Res> {
  __$FocusSessionModelCopyWithImpl(this._self, this._then);

  final _FocusSessionModel _self;
  final $Res Function(_FocusSessionModel) _then;

/// Create a copy of FocusSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? taskId = freezed,Object? durationMinutes = null,Object? startedAt = null,Object? endedAt = freezed,Object? createdAt = null,}) {
  return _then(_FocusSessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,taskId: freezed == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as String,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
