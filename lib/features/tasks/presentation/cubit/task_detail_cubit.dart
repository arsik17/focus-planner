import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/features/tasks/domain/entities/attachment.dart';
import 'package:focus_planner/features/tasks/domain/entities/subtask.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/create_subtask.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/delete_attachment.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/delete_subtask.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/delete_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/toggle_subtask.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/update_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/upload_attachment.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  final GetTaskById _getTaskById;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;
  final CreateSubtask _createSubtask;
  final ToggleSubtask _toggleSubtask;
  final DeleteSubtask _deleteSubtask;
  final UploadAttachment _uploadAttachment;
  final DeleteAttachment _deleteAttachment;

  TaskDetailCubit({
    required GetTaskById getTaskById,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
    required CreateSubtask createSubtask,
    required ToggleSubtask toggleSubtask,
    required DeleteSubtask deleteSubtask,
    required UploadAttachment uploadAttachment,
    required DeleteAttachment deleteAttachment,
  })  : _getTaskById = getTaskById,
        _updateTask = updateTask,
        _deleteTask = deleteTask,
        _createSubtask = createSubtask,
        _toggleSubtask = toggleSubtask,
        _deleteSubtask = deleteSubtask,
        _uploadAttachment = uploadAttachment,
        _deleteAttachment = deleteAttachment,
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

    final updated = Task(
      id: task.id,
      userId: task.userId,
      categoryId: task.categoryId,
      title: task.title,
      description: task.description,
      priority: task.priority,
      status: newStatus,
      dueDate: task.dueDate,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
      category: task.category,
      subtasks: task.subtasks,
      attachments: task.attachments,
    );
    emit(state.copyWith(task: updated));

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
      emit(state.copyWith(task: task));
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

  Future<void> addSubtask(String title) async {
    final task = state.task;
    if (task == null) return;

    try {
      final subtask = await _createSubtask(CreateSubtaskParams(
        taskId: task.id,
        title: title,
      ));
      final updatedSubtasks = [...task.subtasks, subtask];
      _emitWithSubtasks(task, updatedSubtasks);
    } catch (e) {
      emit(state.copyWith(
        status: TaskDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> toggleSubtaskStatus(String subtaskId, bool isCompleted) async {
    final task = state.task;
    if (task == null) return;

    final updatedSubtasks = task.subtasks.map((s) {
      if (s.id == subtaskId) {
        return Subtask(
          id: s.id,
          taskId: s.taskId,
          title: s.title,
          isCompleted: isCompleted,
          sortOrder: s.sortOrder,
          createdAt: s.createdAt,
        );
      }
      return s;
    }).toList();
    _emitWithSubtasks(task, updatedSubtasks);

    try {
      await _toggleSubtask(ToggleSubtaskParams(
        id: subtaskId,
        isCompleted: isCompleted,
      ));
    } catch (e) {
      _emitWithSubtasks(task, task.subtasks);
    }
  }

  Future<void> removeSubtask(String subtaskId) async {
    final task = state.task;
    if (task == null) return;

    final original = task.subtasks;
    final updatedSubtasks =
        task.subtasks.where((s) => s.id != subtaskId).toList();
    _emitWithSubtasks(task, updatedSubtasks);

    try {
      await _deleteSubtask(subtaskId);
    } catch (e) {
      _emitWithSubtasks(task, original);
    }
  }

  Future<void> addAttachment(String filePath, String fileName) async {
    final task = state.task;
    if (task == null) return;

    try {
      final attachment = await _uploadAttachment(UploadAttachmentParams(
        taskId: task.id,
        filePath: filePath,
        fileName: fileName,
      ));
      final updatedAttachments = [...task.attachments, attachment];
      _emitWithAttachments(task, updatedAttachments);
    } catch (e) {
      emit(state.copyWith(
        status: TaskDetailStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> removeAttachment(String attachmentId, String storagePath) async {
    final task = state.task;
    if (task == null) return;

    final original = task.attachments;
    final updated =
        task.attachments.where((a) => a.id != attachmentId).toList();
    _emitWithAttachments(task, updated);

    try {
      await _deleteAttachment(DeleteAttachmentParams(
        attachmentId: attachmentId,
        storagePath: storagePath,
      ));
    } catch (e) {
      _emitWithAttachments(task, original);
    }
  }

  void _emitWithAttachments(Task task, List<Attachment> attachments) {
    final updated = Task(
      id: task.id,
      userId: task.userId,
      categoryId: task.categoryId,
      title: task.title,
      description: task.description,
      priority: task.priority,
      status: task.status,
      dueDate: task.dueDate,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
      category: task.category,
      subtasks: task.subtasks,
      attachments: attachments,
    );
    emit(state.copyWith(task: updated));
  }

  void _emitWithSubtasks(Task task, List<Subtask> subtasks) {
    final updated = Task(
      id: task.id,
      userId: task.userId,
      categoryId: task.categoryId,
      title: task.title,
      description: task.description,
      priority: task.priority,
      status: task.status,
      dueDate: task.dueDate,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
      category: task.category,
      subtasks: subtasks,
      attachments: task.attachments,
    );
    emit(state.copyWith(task: updated));
  }
}
