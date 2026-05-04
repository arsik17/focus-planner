import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class CreateTask implements UseCase<Task, CreateTaskParams> {
  final TaskRepository _taskRepository;
  const CreateTask(this._taskRepository);

  @override
  Future<Task> call(CreateTaskParams params) async {
    return await _taskRepository.createTask(
      title: params.title,
      description: params.description,
      categoryId: params.categoryId,
      priority: params.priority,
      dueDate: params.dueDate,
    );
  }
}

class CreateTaskParams {
  final String title;
  final String? description;
  final String? categoryId;
  final int priority;
  final DateTime? dueDate;

  const CreateTaskParams({
    required this.title,
    this.description,
    this.categoryId,
    required this.priority,
    this.dueDate,
  });
}
