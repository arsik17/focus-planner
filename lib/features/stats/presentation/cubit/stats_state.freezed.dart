// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StatsState {

 StatsStatus get status; int get totalTasks; int get completedTasks; int get totalFocusMinutes; int get totalSessions; int get currentStreak; String get topCategoryName; int get topCategoryTaskCount; Map<String, int> get weeklyFocusMinutes; String? get errorMessage;
/// Create a copy of StatsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsStateCopyWith<StatsState> get copyWith => _$StatsStateCopyWithImpl<StatsState>(this as StatsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatsState&&(identical(other.status, status) || other.status == status)&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks)&&(identical(other.totalFocusMinutes, totalFocusMinutes) || other.totalFocusMinutes == totalFocusMinutes)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.topCategoryName, topCategoryName) || other.topCategoryName == topCategoryName)&&(identical(other.topCategoryTaskCount, topCategoryTaskCount) || other.topCategoryTaskCount == topCategoryTaskCount)&&const DeepCollectionEquality().equals(other.weeklyFocusMinutes, weeklyFocusMinutes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,totalTasks,completedTasks,totalFocusMinutes,totalSessions,currentStreak,topCategoryName,topCategoryTaskCount,const DeepCollectionEquality().hash(weeklyFocusMinutes),errorMessage);

@override
String toString() {
  return 'StatsState(status: $status, totalTasks: $totalTasks, completedTasks: $completedTasks, totalFocusMinutes: $totalFocusMinutes, totalSessions: $totalSessions, currentStreak: $currentStreak, topCategoryName: $topCategoryName, topCategoryTaskCount: $topCategoryTaskCount, weeklyFocusMinutes: $weeklyFocusMinutes, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $StatsStateCopyWith<$Res>  {
  factory $StatsStateCopyWith(StatsState value, $Res Function(StatsState) _then) = _$StatsStateCopyWithImpl;
@useResult
$Res call({
 StatsStatus status, int totalTasks, int completedTasks, int totalFocusMinutes, int totalSessions, int currentStreak, String topCategoryName, int topCategoryTaskCount, Map<String, int> weeklyFocusMinutes, String? errorMessage
});




}
/// @nodoc
class _$StatsStateCopyWithImpl<$Res>
    implements $StatsStateCopyWith<$Res> {
  _$StatsStateCopyWithImpl(this._self, this._then);

  final StatsState _self;
  final $Res Function(StatsState) _then;

/// Create a copy of StatsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? totalTasks = null,Object? completedTasks = null,Object? totalFocusMinutes = null,Object? totalSessions = null,Object? currentStreak = null,Object? topCategoryName = null,Object? topCategoryTaskCount = null,Object? weeklyFocusMinutes = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatsStatus,totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as int,totalFocusMinutes: null == totalFocusMinutes ? _self.totalFocusMinutes : totalFocusMinutes // ignore: cast_nullable_to_non_nullable
as int,totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,topCategoryName: null == topCategoryName ? _self.topCategoryName : topCategoryName // ignore: cast_nullable_to_non_nullable
as String,topCategoryTaskCount: null == topCategoryTaskCount ? _self.topCategoryTaskCount : topCategoryTaskCount // ignore: cast_nullable_to_non_nullable
as int,weeklyFocusMinutes: null == weeklyFocusMinutes ? _self.weeklyFocusMinutes : weeklyFocusMinutes // ignore: cast_nullable_to_non_nullable
as Map<String, int>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StatsState].
extension StatsStatePatterns on StatsState {

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatsState value)  $default,){
final _that = this;
switch (_that) {
case _StatsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatsState value)?  $default,){
final _that = this;
switch (_that) {
case _StatsState() when $default != null:
return $default(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StatsStatus status,  int totalTasks,  int completedTasks,  int totalFocusMinutes,  int totalSessions,  int currentStreak,  String topCategoryName,  int topCategoryTaskCount,  Map<String, int> weeklyFocusMinutes,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatsState() when $default != null:
return $default(_that.status,_that.totalTasks,_that.completedTasks,_that.totalFocusMinutes,_that.totalSessions,_that.currentStreak,_that.topCategoryName,_that.topCategoryTaskCount,_that.weeklyFocusMinutes,_that.errorMessage);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StatsStatus status,  int totalTasks,  int completedTasks,  int totalFocusMinutes,  int totalSessions,  int currentStreak,  String topCategoryName,  int topCategoryTaskCount,  Map<String, int> weeklyFocusMinutes,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _StatsState():
return $default(_that.status,_that.totalTasks,_that.completedTasks,_that.totalFocusMinutes,_that.totalSessions,_that.currentStreak,_that.topCategoryName,_that.topCategoryTaskCount,_that.weeklyFocusMinutes,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StatsStatus status,  int totalTasks,  int completedTasks,  int totalFocusMinutes,  int totalSessions,  int currentStreak,  String topCategoryName,  int topCategoryTaskCount,  Map<String, int> weeklyFocusMinutes,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _StatsState() when $default != null:
return $default(_that.status,_that.totalTasks,_that.completedTasks,_that.totalFocusMinutes,_that.totalSessions,_that.currentStreak,_that.topCategoryName,_that.topCategoryTaskCount,_that.weeklyFocusMinutes,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _StatsState implements StatsState {
  const _StatsState({this.status = StatsStatus.initial, this.totalTasks = 0, this.completedTasks = 0, this.totalFocusMinutes = 0, this.totalSessions = 0, this.currentStreak = 0, this.topCategoryName = '', this.topCategoryTaskCount = 0, this.weeklyFocusMinutes = const {}, this.errorMessage});


@override@JsonKey() final  StatsStatus status;
@override@JsonKey() final  int totalTasks;
@override@JsonKey() final  int completedTasks;
@override@JsonKey() final  int totalFocusMinutes;
@override@JsonKey() final  int totalSessions;
@override@JsonKey() final  int currentStreak;
@override@JsonKey() final  String topCategoryName;
@override@JsonKey() final  int topCategoryTaskCount;
@override@JsonKey() final  Map<String, int> weeklyFocusMinutes;
@override final  String? errorMessage;

/// Create a copy of StatsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsStateCopyWith<_StatsState> get copyWith => __$StatsStateCopyWithImpl<_StatsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatsState&&(identical(other.status, status) || other.status == status)&&(identical(other.totalTasks, totalTasks) || other.totalTasks == totalTasks)&&(identical(other.completedTasks, completedTasks) || other.completedTasks == completedTasks)&&(identical(other.totalFocusMinutes, totalFocusMinutes) || other.totalFocusMinutes == totalFocusMinutes)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.topCategoryName, topCategoryName) || other.topCategoryName == topCategoryName)&&(identical(other.topCategoryTaskCount, topCategoryTaskCount) || other.topCategoryTaskCount == topCategoryTaskCount)&&const DeepCollectionEquality().equals(other.weeklyFocusMinutes, weeklyFocusMinutes)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,totalTasks,completedTasks,totalFocusMinutes,totalSessions,currentStreak,topCategoryName,topCategoryTaskCount,const DeepCollectionEquality().hash(weeklyFocusMinutes),errorMessage);

@override
String toString() {
  return 'StatsState(status: $status, totalTasks: $totalTasks, completedTasks: $completedTasks, totalFocusMinutes: $totalFocusMinutes, totalSessions: $totalSessions, currentStreak: $currentStreak, topCategoryName: $topCategoryName, topCategoryTaskCount: $topCategoryTaskCount, weeklyFocusMinutes: $weeklyFocusMinutes, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$StatsStateCopyWith<$Res> implements $StatsStateCopyWith<$Res> {
  factory _$StatsStateCopyWith(_StatsState value, $Res Function(_StatsState) _then) = __$StatsStateCopyWithImpl;
@override @useResult
$Res call({
 StatsStatus status, int totalTasks, int completedTasks, int totalFocusMinutes, int totalSessions, int currentStreak, String topCategoryName, int topCategoryTaskCount, Map<String, int> weeklyFocusMinutes, String? errorMessage
});




}
/// @nodoc
class __$StatsStateCopyWithImpl<$Res>
    implements _$StatsStateCopyWith<$Res> {
  __$StatsStateCopyWithImpl(this._self, this._then);

  final _StatsState _self;
  final $Res Function(_StatsState) _then;

/// Create a copy of StatsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? totalTasks = null,Object? completedTasks = null,Object? totalFocusMinutes = null,Object? totalSessions = null,Object? currentStreak = null,Object? topCategoryName = null,Object? topCategoryTaskCount = null,Object? weeklyFocusMinutes = null,Object? errorMessage = freezed,}) {
  return _then(_StatsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StatsStatus,totalTasks: null == totalTasks ? _self.totalTasks : totalTasks // ignore: cast_nullable_to_non_nullable
as int,completedTasks: null == completedTasks ? _self.completedTasks : completedTasks // ignore: cast_nullable_to_non_nullable
as int,totalFocusMinutes: null == totalFocusMinutes ? _self.totalFocusMinutes : totalFocusMinutes // ignore: cast_nullable_to_non_nullable
as int,totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,topCategoryName: null == topCategoryName ? _self.topCategoryName : topCategoryName // ignore: cast_nullable_to_non_nullable
as String,topCategoryTaskCount: null == topCategoryTaskCount ? _self.topCategoryTaskCount : topCategoryTaskCount // ignore: cast_nullable_to_non_nullable
as int,weeklyFocusMinutes: null == weeklyFocusMinutes ? _self.weeklyFocusMinutes : weeklyFocusMinutes // ignore: cast_nullable_to_non_nullable
as Map<String, int>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}

// dart format on
