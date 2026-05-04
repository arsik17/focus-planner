import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/create_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/update_task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_form_state.dart';

class TaskFormCubit extends Cubit<TaskFormState> {
  final CreateTask _createTask;
  final UpdateTask _updateTask;

  TaskFormCubit({
    required CreateTask createTask,
    required UpdateTask updateTask,
  })  : _createTask = createTask,
        _updateTask = updateTask,
        super(const TaskFormState());

  Future<void> addTask({
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    DateTime? dueDate,
  }) async {
    emit(state.copyWith(status: TaskFormStatus.loading, errorMessage: null));

    try {
      await _createTask(CreateTaskParams(
        title: title,
        description: description,
        categoryId: categoryId,
        priority: priority,
        dueDate: dueDate,
      ));
      emit(state.copyWith(status: TaskFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: TaskFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> editTask({
    required String id,
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    required String status,
    DateTime? dueDate,
  }) async {
    emit(state.copyWith(status: TaskFormStatus.loading, errorMessage: null));

    try {
      await _updateTask(UpdateTaskParams(
        id: id,
        title: title,
        description: description,
        categoryId: categoryId,
        priority: priority,
        status: status,
        dueDate: dueDate,
      ));
      emit(state.copyWith(status: TaskFormStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: TaskFormStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
