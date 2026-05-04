import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/subtask.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class CreateSubtask implements UseCase<Subtask, CreateSubtaskParams> {
  final TaskRepository _taskRepository;
  const CreateSubtask(this._taskRepository);

  @override
  Future<Subtask> call(CreateSubtaskParams params) async {
    return await _taskRepository.createSubtask(
      taskId: params.taskId,
      title: params.title,
    );
  }
}

class CreateSubtaskParams {
  final String taskId;
  final String title;

  const CreateSubtaskParams({
    required this.taskId,
    required this.title,
  });
}
