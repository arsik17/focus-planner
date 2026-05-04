import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';

part 'task_list_state.freezed.dart';

enum TaskListStatus { initial, loading, success, failure }

@freezed
abstract class TaskListState with _$TaskListState {
  const factory TaskListState({
    @Default(TaskListStatus.initial) TaskListStatus status,
    @Default([]) List<Task> tasks,
    String? selectedCategoryId,
    String? errorMessage,
  }) = _TaskListState;
}
