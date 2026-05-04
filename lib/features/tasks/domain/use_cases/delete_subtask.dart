import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class DeleteSubtask implements UseCase<void, String> {
  final TaskRepository _taskRepository;
  const DeleteSubtask(this._taskRepository);

  @override
  Future<void> call(String id) async {
    await _taskRepository.deleteSubtask(id);
  }
}
