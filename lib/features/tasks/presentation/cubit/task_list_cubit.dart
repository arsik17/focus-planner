import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/delete_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_state.dart';

class TaskListCubit extends Cubit<TaskListState> {
  final GetTasks _getTasks;
  final DeleteTask _deleteTask;

  TaskListCubit({
    required GetTasks getTasks,
    required DeleteTask deleteTask,
  })  : _getTasks = getTasks,
        _deleteTask = deleteTask,
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
