import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/auth/domain/repository/auth_repository.dart';

class Logout implements UseCase<void, NoParams> {
  final AuthRepository _authRepository;
  const Logout(this._authRepository);

  @override
  Future<void> call(params) async {
    return await _authRepository.logout();
  }
}
