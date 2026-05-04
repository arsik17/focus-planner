import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';

part 'task_detail_state.freezed.dart';

enum TaskDetailStatus { initial, loading, success, failure }

@freezed
abstract class TaskDetailState with _$TaskDetailState {
  const factory TaskDetailState({
    @Default(TaskDetailStatus.initial) TaskDetailStatus status,
    Task? task,
    String? errorMessage,
  }) = _TaskDetailState;
}
