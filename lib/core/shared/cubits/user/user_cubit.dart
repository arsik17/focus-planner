import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/entities/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(UserInitial());
    } else {
      emit(UserLoggedIn(user));
    }
  }
}
