// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState()';
}


}

/// @nodoc
class $UserStateCopyWith<$Res>  {
$UserStateCopyWith(UserState _, $Res Function(UserState) __);
}


/// Adds pattern-matching-related methods to [UserState].
extension UserStatePatterns on UserState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UserInitial value)?  initial,TResult Function( UserLoggedIn value)?  loggedIn,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial(_that);case UserLoggedIn() when loggedIn != null:
return loggedIn(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UserInitial value)  initial,required TResult Function( UserLoggedIn value)  loggedIn,}){
final _that = this;
switch (_that) {
case UserInitial():
return initial(_that);case UserLoggedIn():
return loggedIn(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UserInitial value)?  initial,TResult? Function( UserLoggedIn value)?  loggedIn,}){
final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial(_that);case UserLoggedIn() when loggedIn != null:
return loggedIn(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( User user)?  loggedIn,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial();case UserLoggedIn() when loggedIn != null:
return loggedIn(_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( User user)  loggedIn,}) {final _that = this;
switch (_that) {
case UserInitial():
return initial();case UserLoggedIn():
return loggedIn(_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( User user)?  loggedIn,}) {final _that = this;
switch (_that) {
case UserInitial() when initial != null:
return initial();case UserLoggedIn() when loggedIn != null:
return loggedIn(_that.user);case _:
  return null;

}
}

}

/// @nodoc


class UserInitial implements UserState {
  const UserInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserState.initial()';
}


}




/// @nodoc


class UserLoggedIn implements UserState {
  const UserLoggedIn({required this.user});
  

 final  User user;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLoggedInCopyWith<UserLoggedIn> get copyWith => _$UserLoggedInCopyWithImpl<UserLoggedIn>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLoggedIn&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'UserState.loggedIn(user: $user)';
}


}

/// @nodoc
abstract mixin class $UserLoggedInCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory $UserLoggedInCopyWith(UserLoggedIn value, $Res Function(UserLoggedIn) _then) = _$UserLoggedInCopyWithImpl;
@useResult
$Res call({
 User user
});




}
/// @nodoc
class _$UserLoggedInCopyWithImpl<$Res>
    implements $UserLoggedInCopyWith<$Res> {
  _$UserLoggedInCopyWithImpl(this._self, this._then);

  final UserLoggedIn _self;
  final $Res Function(UserLoggedIn) _then;

/// Create a copy of UserState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(UserLoggedIn(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

// dart format on
