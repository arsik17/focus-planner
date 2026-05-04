// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => _TaskModel(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  categoryId: json['category_id'] as String?,
  title: json['title'] as String,
  description: json['description'] as String?,
  priority: (json['priority'] as num).toInt(),
  status: json['status'] as String,
  dueDate: json['due_date'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  category: json['categories'] == null
      ? null
      : CategoryModel.fromJson(json['categories'] as Map<String, dynamic>),
  subtasks:
      (json['subtasks'] as List<dynamic>?)
          ?.map((e) => SubtaskModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TaskModelToJson(_TaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'category_id': instance.categoryId,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'status': instance.status,
      'due_date': instance.dueDate,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'categories': instance.category,
      'subtasks': instance.subtasks,
      'attachments': instance.attachments,
    };
