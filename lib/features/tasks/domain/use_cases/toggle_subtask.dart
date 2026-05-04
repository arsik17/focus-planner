import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/subtask.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class ToggleSubtask implements UseCase<Subtask, ToggleSubtaskParams> {
  final TaskRepository _taskRepository;
  const ToggleSubtask(this._taskRepository);

  @override
  Future<Subtask> call(ToggleSubtaskParams params) async {
    return await _taskRepository.toggleSubtask(
      id: params.id,
      isCompleted: params.isCompleted,
    );
  }
}

class ToggleSubtaskParams {
  final String id;
  final bool isCompleted;

  const ToggleSubtaskParams({
    required this.id,
    required this.isCompleted,
  });
}
