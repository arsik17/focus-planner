import 'package:focus_planner/features/focus/domain/entities/focus_session.dart';

abstract class FocusRepository {
  Future<FocusSession> createSession({
    required String taskId,
    required int durationMinutes,
    required DateTime startedAt,
  });
  Future<FocusSession> endSession({
    required String id,
    required DateTime endedAt,
  });
  Future<List<FocusSession>> getSessions();
}
