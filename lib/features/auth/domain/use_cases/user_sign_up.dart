import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/core/shared/entities/user.dart';
import 'package:focus_planner/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository _authRepository;
  const UserSignUp(this._authRepository);

  @override
  Future<User> call(UserSignUpParams params) async {
    return await _authRepository.signUp(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  const UserSignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
