import 'package:focus_planner/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> getTaskById(String id);
  Future<Task> createTask({
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    DateTime? dueDate,
  });
  Future<Task> updateTask({
    required String id,
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    required String status,
    DateTime? dueDate,
  });
  Future<void> deleteTask(String id);
}
