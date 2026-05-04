import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:focus_planner/features/tasks/domain/entities/subtask.dart';

part 'subtask_model.g.dart';
part 'subtask_model.freezed.dart';

@freezed
abstract class SubtaskModel with _$SubtaskModel {
  const SubtaskModel._();

  const factory SubtaskModel({
    required String id,
    @JsonKey(name: 'task_id') required String taskId,
    required String title,
    @JsonKey(name: 'is_completed') required bool isCompleted,
    @JsonKey(name: 'sort_order') required int sortOrder,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _SubtaskModel;

  factory SubtaskModel.fromJson(Map<String, dynamic> json) =>
      _$SubtaskModelFromJson(json);

  Subtask toEntity() {
    return Subtask(
      id: id,
      taskId: taskId,
      title: title,
      isCompleted: isCompleted,
      sortOrder: sortOrder,
      createdAt: DateTime.parse(createdAt),
    );
  }
}
