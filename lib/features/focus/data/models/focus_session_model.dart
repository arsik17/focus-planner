import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:focus_planner/features/focus/domain/entities/focus_session.dart';

part 'focus_session_model.g.dart';
part 'focus_session_model.freezed.dart';

@freezed
abstract class FocusSessionModel with _$FocusSessionModel {
  const FocusSessionModel._();

  const factory FocusSessionModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'task_id') String? taskId,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'started_at') required String startedAt,
    @JsonKey(name: 'ended_at') String? endedAt,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _FocusSessionModel;

  factory FocusSessionModel.fromJson(Map<String, dynamic> json) =>
      _$FocusSessionModelFromJson(json);

  FocusSession toEntity() {
    return FocusSession(
      id: id,
      userId: userId,
      taskId: taskId,
      durationMinutes: durationMinutes,
      startedAt: DateTime.parse(startedAt),
      endedAt: endedAt != null ? DateTime.parse(endedAt!) : null,
      createdAt: DateTime.parse(createdAt),
    );
  }

  factory FocusSessionModel.fromEntity(FocusSession session) {
    return FocusSessionModel(
      id: session.id,
      userId: session.userId,
      taskId: session.taskId,
      durationMinutes: session.durationMinutes,
      startedAt: session.startedAt.toIso8601String(),
      endedAt: session.endedAt?.toIso8601String(),
      createdAt: session.createdAt.toIso8601String(),
    );
  }
}
