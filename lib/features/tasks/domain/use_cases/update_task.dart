import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class UpdateTask implements UseCase<Task, UpdateTaskParams> {
  final TaskRepository _taskRepository;
  const UpdateTask(this._taskRepository);

  @override
  Future<Task> call(UpdateTaskParams params) async {
    return await _taskRepository.updateTask(
      id: params.id,
      title: params.title,
      description: params.description,
      categoryId: params.categoryId,
      priority: params.priority,
      status: params.status,
      dueDate: params.dueDate,
    );
  }
}

class UpdateTaskParams {
  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final int priority;
  final String status;
  final DateTime? dueDate;

  const UpdateTaskParams({
    required this.id,
    required this.title,
    this.description,
    this.categoryId,
    required this.priority,
    required this.status,
    this.dueDate,
  });
}
