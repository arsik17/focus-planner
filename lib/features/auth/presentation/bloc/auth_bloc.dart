import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/error/server_exception.dart';
import 'package:focus_planner/features/auth/domain/use_cases/user_sign_in.dart';
import 'package:focus_planner/features/auth/domain/use_cases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;

  AuthBloc({required UserSignUp userSignUp, required UserSignIn userSignIn})
    : _userSignUp = userSignUp,
      _userSignIn = userSignIn,
      super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      try {
        final uid = await _userSignUp(
          UserSignUpParams(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );
        emit(AuthSuccess(uid));
      } on ServerException catch (e) {
        emit(AuthFailure(e.message));
      }
    });
    on<AuthSignIn>((event, emit) async {
      emit(AuthLoading());
      try {
        final uid = await _userSignIn(
          UserSignInParams(email: event.email, password: event.password),
        );
        emit(AuthSuccess(uid));
      } on ServerException catch (e) {
        emit(AuthFailure(e.message));
      }
    });
  }
}
