import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class GetTaskById implements UseCase<Task, String> {
  final TaskRepository _taskRepository;
  const GetTaskById(this._taskRepository);

  @override
  Future<Task> call(String id) async {
    return await _taskRepository.getTaskById(id);
  }
}
