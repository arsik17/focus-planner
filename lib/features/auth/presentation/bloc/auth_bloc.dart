import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/error/server_exception.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/core/shared/entities/user.dart';
import 'package:focus_planner/features/auth/domain/use_cases/current_user.dart';
import 'package:focus_planner/features/auth/domain/use_cases/user_sign_in.dart';
import 'package:focus_planner/features/auth/domain/use_cases/logout.dart';
import 'package:focus_planner/features/auth/domain/use_cases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final Logout _logout;
  final UserCubit _userCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required Logout logout,
    required UserCubit userCubit,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       _logout = logout,
       _userCubit = userCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthSignUp>((event, emit) async {
      try {
        final user = await _userSignUp(
          UserSignUpParams(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );
        _emitAuthSuccess(user, emit);
      } on ServerException catch (e) {
        emit(AuthFailure(e.message));
      }
    });

    on<AuthSignIn>((event, emit) async {
      try {
        final user = await _userSignIn(
          UserSignInParams(email: event.email, password: event.password),
        );
        _emitAuthSuccess(user, emit);
      } on ServerException catch (e) {
        emit(AuthFailure(e.message));
      }
    });

    on<AuthLogout>((event, emit) async {
      try {
        await _logout(NoParams());
        _userCubit.updateUser(null);
        emit(AuthInitial());
      } on ServerException catch (e) {
        emit(AuthFailure(e.message));
      }
    });

    on<AuthIsUserLoggedIn>((event, emit) async {
      try {
        final user = await _currentUser(NoParams());
        if (user != null) {
          _emitAuthSuccess(user, emit);
        } else {
          emit(AuthInitial());
        }
      } on ServerException catch (e) {
        emit(AuthFailure(e.message));
      }
    });
  }

  void _emitAuthSuccess(User user, emit) {
    _userCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
