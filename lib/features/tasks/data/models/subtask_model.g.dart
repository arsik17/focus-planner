// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subtask_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubtaskModel _$SubtaskModelFromJson(Map<String, dynamic> json) =>
    _SubtaskModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      title: json['title'] as String,
      isCompleted: json['is_completed'] as bool,
      sortOrder: (json['sort_order'] as num).toInt(),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$SubtaskModelToJson(_SubtaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'title': instance.title,
      'is_completed': instance.isCompleted,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt,
    };
