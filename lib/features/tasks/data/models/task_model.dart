import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:focus_planner/features/categories/data/models/category_model.dart';
import 'package:focus_planner/features/tasks/data/models/subtask_model.dart';
import 'package:focus_planner/features/tasks/data/models/attachment_model.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';

part 'task_model.g.dart';
part 'task_model.freezed.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const TaskModel._();

  const factory TaskModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'category_id') String? categoryId,
    required String title,
    String? description,
    required int priority,
    required String status,
    @JsonKey(name: 'due_date') String? dueDate,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'categories') CategoryModel? category,
    @Default([]) List<SubtaskModel> subtasks,
    @Default([]) List<AttachmentModel> attachments,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Task toEntity() {
    return Task(
      id: id,
      userId: userId,
      categoryId: categoryId,
      title: title,
      description: description,
      priority: priority,
      status: status,
      dueDate: dueDate != null ? DateTime.parse(dueDate!) : null,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      category: category?.toEntity(),
      subtasks: subtasks.map((s) => s.toEntity()).toList(),
      attachments: attachments.map((a) => a.toEntity()).toList(),
    );
  }
}
