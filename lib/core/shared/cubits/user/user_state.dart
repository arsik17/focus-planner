import 'package:focus_planner/core/shared/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
sealed class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;
  const factory UserState.loggedIn({required User user}) = UserLoggedIn;
}
