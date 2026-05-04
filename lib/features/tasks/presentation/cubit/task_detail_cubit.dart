import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/delete_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/update_task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final GetTaskById _getTaskById;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;

  TaskDetailCubit({
    required GetTaskById getTaskById,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
  })  : _getTaskById = getTaskById,
        _updateTask = updateTask,
        _deleteTask = deleteTask,
        super(const TaskDetailState());

  Future<void> loadTask(String id) async {
    emit(state.copyWith(status: TaskDetailStatus.loading, errorMessage: null));

    try {
      final task = await _getTaskById(id);
      emit(state.copyWith(
        status: TaskDetailStatus.success,
        task: task,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TaskDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> updateStatus(String newStatus) async {
    final task = state.task;
    if (task == null) return;

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
      await loadTask(task.id);
    } catch (e) {
      emit(state.copyWith(
        status: TaskDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> removeTask() async {
    final task = state.task;
    if (task == null) return;

    try {
      await _deleteTask(task.id);
    } catch (e) {
      emit(state.copyWith(
        status: TaskDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
