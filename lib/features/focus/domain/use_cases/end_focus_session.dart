import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/focus/domain/entities/focus_session.dart';
import 'package:focus_planner/features/focus/domain/repository/focus_repository.dart';

class EndFocusSession
    implements UseCase<FocusSession, EndFocusSessionParams> {
  final FocusRepository _focusRepository;
  const EndFocusSession(this._focusRepository);

  @override
  Future<FocusSession> call(EndFocusSessionParams params) async {
    return await _focusRepository.endSession(
      id: params.id,
      endedAt: params.endedAt,
    );
  }
}

class EndFocusSessionParams {
  final String id;
  final DateTime endedAt;

  const EndFocusSessionParams({
    required this.id,
    required this.endedAt,
  });
}
