// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subtask_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubtaskModel {

 String get id;@JsonKey(name: 'task_id') String get taskId; String get title;@JsonKey(name: 'is_completed') bool get isCompleted;@JsonKey(name: 'sort_order') int get sortOrder;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtaskModelCopyWith<SubtaskModel> get copyWith => _$SubtaskModelCopyWithImpl<SubtaskModel>(this as SubtaskModel, _$identity);

  /// Serializes this SubtaskModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubtaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.title, title) || other.title == title)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,title,isCompleted,sortOrder,createdAt);

@override
String toString() {
  return 'SubtaskModel(id: $id, taskId: $taskId, title: $title, isCompleted: $isCompleted, sortOrder: $sortOrder, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SubtaskModelCopyWith<$Res>  {
  factory $SubtaskModelCopyWith(SubtaskModel value, $Res Function(SubtaskModel) _then) = _$SubtaskModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId, String title,@JsonKey(name: 'is_completed') bool isCompleted,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$SubtaskModelCopyWithImpl<$Res>
    implements $SubtaskModelCopyWith<$Res> {
  _$SubtaskModelCopyWithImpl(this._self, this._then);

  final SubtaskModel _self;
  final $Res Function(SubtaskModel) _then;

/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? taskId = null,Object? title = null,Object? isCompleted = null,Object? sortOrder = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SubtaskModel].
extension SubtaskModelPatterns on SubtaskModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubtaskModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubtaskModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubtaskModel value)  $default,){
final _that = this;
switch (_that) {
case _SubtaskModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubtaskModel value)?  $default,){
final _that = this;
switch (_that) {
case _SubtaskModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId,  String title, @JsonKey(name: 'is_completed')  bool isCompleted, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubtaskModel() when $default != null:
return $default(_that.id,_that.taskId,_that.title,_that.isCompleted,_that.sortOrder,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'task_id')  String taskId,  String title, @JsonKey(name: 'is_completed')  bool isCompleted, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _SubtaskModel():
return $default(_that.id,_that.taskId,_that.title,_that.isCompleted,_that.sortOrder,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'task_id')  String taskId,  String title, @JsonKey(name: 'is_completed')  bool isCompleted, @JsonKey(name: 'sort_order')  int sortOrder, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SubtaskModel() when $default != null:
return $default(_that.id,_that.taskId,_that.title,_that.isCompleted,_that.sortOrder,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubtaskModel extends SubtaskModel {
  const _SubtaskModel({required this.id, @JsonKey(name: 'task_id') required this.taskId, required this.title, @JsonKey(name: 'is_completed') required this.isCompleted, @JsonKey(name: 'sort_order') required this.sortOrder, @JsonKey(name: 'created_at') required this.createdAt}): super._();
  factory _SubtaskModel.fromJson(Map<String, dynamic> json) => _$SubtaskModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'task_id') final  String taskId;
@override final  String title;
@override@JsonKey(name: 'is_completed') final  bool isCompleted;
@override@JsonKey(name: 'sort_order') final  int sortOrder;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtaskModelCopyWith<_SubtaskModel> get copyWith => __$SubtaskModelCopyWithImpl<_SubtaskModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtaskModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubtaskModel&&(identical(other.id, id) || other.id == id)&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.title, title) || other.title == title)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,taskId,title,isCompleted,sortOrder,createdAt);

@override
String toString() {
  return 'SubtaskModel(id: $id, taskId: $taskId, title: $title, isCompleted: $isCompleted, sortOrder: $sortOrder, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SubtaskModelCopyWith<$Res> implements $SubtaskModelCopyWith<$Res> {
  factory _$SubtaskModelCopyWith(_SubtaskModel value, $Res Function(_SubtaskModel) _then) = __$SubtaskModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'task_id') String taskId, String title,@JsonKey(name: 'is_completed') bool isCompleted,@JsonKey(name: 'sort_order') int sortOrder,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$SubtaskModelCopyWithImpl<$Res>
    implements _$SubtaskModelCopyWith<$Res> {
  __$SubtaskModelCopyWithImpl(this._self, this._then);

  final _SubtaskModel _self;
  final $Res Function(_SubtaskModel) _then;

/// Create a copy of SubtaskModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? taskId = null,Object? title = null,Object? isCompleted = null,Object? sortOrder = null,Object? createdAt = null,}) {
  return _then(_SubtaskModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
