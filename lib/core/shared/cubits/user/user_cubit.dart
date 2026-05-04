import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/cubits/user/user_state.dart';
import 'package:focus_planner/core/shared/entities/user.dart';

class UserCubit extends Cubit<UserState> {
  bool sessionChecked = false;

  UserCubit() : super(const UserState.initial());

  void updateUser(User? user) {
    sessionChecked = true;
    if (user == null) {
      emit(const UserState.initial());
    } else {
      emit(UserState.loggedIn(user: user));
    }
  }
}
