import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/focus/domain/entities/focus_session.dart';
import 'package:focus_planner/features/focus/domain/repository/focus_repository.dart';

class GetFocusSessions implements UseCase<List<FocusSession>, NoParams> {
  final FocusRepository _focusRepository;
  const GetFocusSessions(this._focusRepository);

  @override
  Future<List<FocusSession>> call(NoParams params) async {
    return await _focusRepository.getSessions();
  }
}
