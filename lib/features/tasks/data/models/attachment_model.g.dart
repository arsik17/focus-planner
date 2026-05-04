// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttachmentModel _$AttachmentModelFromJson(Map<String, dynamic> json) =>
    _AttachmentModel(
      id: json['id'] as String,
      taskId: json['task_id'] as String,
      imageUrl: json['image_url'] as String,
      fileName: json['file_name'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$AttachmentModelToJson(_AttachmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task_id': instance.taskId,
      'image_url': instance.imageUrl,
      'file_name': instance.fileName,
      'created_at': instance.createdAt,
    };
