import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/focus/domain/entities/focus_session.dart';
import 'package:focus_planner/features/focus/domain/repository/focus_repository.dart';

class CreateFocusSession
    implements UseCase<FocusSession, CreateFocusSessionParams> {
  final FocusRepository _focusRepository;
  const CreateFocusSession(this._focusRepository);

  @override
  Future<FocusSession> call(CreateFocusSessionParams params) async {
    return await _focusRepository.createSession(
      taskId: params.taskId,
      durationMinutes: params.durationMinutes,
      startedAt: params.startedAt,
    );
  }
}

class CreateFocusSessionParams {
  final String taskId;
  final int durationMinutes;
  final DateTime startedAt;

  const CreateFocusSessionParams({
    required this.taskId,
    required this.durationMinutes,
    required this.startedAt,
  });
}
