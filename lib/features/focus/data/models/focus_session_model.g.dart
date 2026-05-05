// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FocusSessionModel _$FocusSessionModelFromJson(Map<String, dynamic> json) =>
    _FocusSessionModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      taskId: json['task_id'] as String?,
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      startedAt: json['started_at'] as String,
      endedAt: json['ended_at'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$FocusSessionModelToJson(_FocusSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'task_id': instance.taskId,
      'duration_minutes': instance.durationMinutes,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'created_at': instance.createdAt,
    };
