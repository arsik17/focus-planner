import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/core/shared/entities/user.dart';
import 'package:focus_planner/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User?, NoParams> {
  final AuthRepository _authRepository;
  CurrentUser(this._authRepository);

  @override
  Future<User?> call(NoParams params) async {
    return _authRepository.getCurrentUser();
  }
}
