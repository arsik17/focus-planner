class FocusSession {
  final String id;
  final String userId;
  final String? taskId;
  final int durationMinutes;
  final DateTime startedAt;
  final DateTime? endedAt;
  final DateTime createdAt;

  FocusSession({
    required this.id,
    required this.userId,
    this.taskId,
    required this.durationMinutes,
    required this.startedAt,
    this.endedAt,
    required this.createdAt,
  });
}
