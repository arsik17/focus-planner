import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/core/shared/entities/user.dart';
import 'package:focus_planner/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository _authRepository;
  const UserSignIn(this._authRepository);

  @override
  Future<User> call(UserSignInParams params) async {
    return await _authRepository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  const UserSignInParams({required this.email, required this.password});
}
