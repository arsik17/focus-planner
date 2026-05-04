import 'package:focus_planner/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;

  TaskRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final models = await _remoteDataSource.getTasks();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Task> getTaskById(String id) async {
    final model = await _remoteDataSource.getTaskById(id);
    return model.toEntity();
  }

  @override
  Future<Task> createTask({
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    DateTime? dueDate,
  }) async {
    final model = await _remoteDataSource.createTask(
      title: title,
      description: description,
      categoryId: categoryId,
      priority: priority,
      dueDate: dueDate,
    );
    return model.toEntity();
  }

  @override
  Future<Task> updateTask({
    required String id,
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    required String status,
    DateTime? dueDate,
  }) async {
    final model = await _remoteDataSource.updateTask(
      id: id,
      title: title,
      description: description,
      categoryId: categoryId,
      priority: priority,
      status: status,
      dueDate: dueDate,
    );
    return model.toEntity();
  }

  @override
  Future<void> deleteTask(String id) async {
    await _remoteDataSource.deleteTask(id);
  }
}
