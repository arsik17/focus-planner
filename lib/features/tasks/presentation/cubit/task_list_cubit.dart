import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/delete_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/update_task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final GetTasks _getTasks;
  final DeleteTask _deleteTask;
  final UpdateTask _updateTask;

  TaskListCubit({
    required GetTasks getTasks,
    required DeleteTask deleteTask,
    required UpdateTask updateTask,
  })  : _getTasks = getTasks,
        _deleteTask = deleteTask,
        _updateTask = updateTask,
        super(const TaskListState());

  Future<void> loadTasks() async {
    emit(state.copyWith(status: TaskListStatus.loading, errorMessage: null));

    try {
      final tasks = await _getTasks(NoParams());
      emit(state.copyWith(
        status: TaskListStatus.success,
        tasks: tasks,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void filterByCategory(String? categoryId) {
    emit(state.copyWith(selectedCategoryId: categoryId));
  }

  Future<void> toggleTaskStatus(Task task) async {
    final newStatus = task.status == 'done' ? 'todo' : 'done';
    final updatedTasks = state.tasks.map((t) {
      if (t.id == task.id) {
        return Task(
          id: t.id,
          userId: t.userId,
          categoryId: t.categoryId,
          title: t.title,
          description: t.description,
          priority: t.priority,
          status: newStatus,
          dueDate: t.dueDate,
          createdAt: t.createdAt,
          updatedAt: t.updatedAt,
          category: t.category,
          subtasks: t.subtasks,
          attachments: t.attachments,
        );
      }
      return t;
    }).toList();
    emit(state.copyWith(tasks: updatedTasks));

    try {
      await _updateTask(UpdateTaskParams(
        id: task.id,
        title: task.title,
        description: task.description,
        categoryId: task.categoryId,
        priority: task.priority,
        status: newStatus,
        dueDate: task.dueDate,
      ));
    } catch (e) {
      emit(state.copyWith(tasks: state.tasks));
    }
  }

  Future<void> removeTask(String id) async {
    try {
      await _deleteTask(id);
      await loadTasks();
    } catch (e) {
      emit(state.copyWith(
        status: TaskListStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
