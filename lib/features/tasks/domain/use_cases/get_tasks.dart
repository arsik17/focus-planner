import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class GetTasks implements UseCase<List<Task>, NoParams> {
  final TaskRepository _taskRepository;
  const GetTasks(this._taskRepository);

  @override
  Future<List<Task>> call(NoParams params) async {
    return await _taskRepository.getTasks();
  }
}
