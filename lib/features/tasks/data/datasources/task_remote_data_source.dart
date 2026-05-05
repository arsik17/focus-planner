import 'dart:io';

import 'package:focus_planner/core/error/server_exception.dart';
import 'package:focus_planner/features/tasks/data/models/attachment_model.dart';
import 'package:focus_planner/features/tasks/data/models/subtask_model.dart';
import 'package:focus_planner/features/tasks/data/models/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTaskById(String id);
  Future<TaskModel> createTask({
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    DateTime? dueDate,
  });
  Future<TaskModel> updateTask({
    required String id,
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    required String status,
    DateTime? dueDate,
  });
  Future<void> deleteTask(String id);
  Future<SubtaskModel> createSubtask({
    required String taskId,
    required String title,
  });
  Future<SubtaskModel> toggleSubtask({
    required String id,
    required bool isCompleted,
  });
  Future<void> deleteSubtask(String id);
  Future<AttachmentModel> uploadAttachment({
    required String taskId,
    required String filePath,
    required String fileName,
  });
  Future<void> deleteAttachment({
    required String attachmentId,
    required String storagePath,
  });
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final SupabaseClient _client;

  TaskRemoteDataSourceImpl(this._client);

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      final response = await _client
          .from('tasks')
          .select('*, categories(*), subtasks(*), attachments(*)')
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => TaskModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    try {
      final response = await _client
          .from('tasks')
          .select('*, categories(*), subtasks(*), attachments(*)')
          .eq('id', id)
          .single();

      return TaskModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TaskModel> createTask({
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    DateTime? dueDate,
  }) async {
    try {
      final userId = _client.auth.currentUser!.id;
      final data = <String, dynamic>{
        'user_id': userId,
        'title': title,
        'priority': priority,
        'status': 'todo',
      };
      if (description != null) data['description'] = description;
      if (categoryId != null) data['category_id'] = categoryId;
      if (dueDate != null) data['due_date'] = dueDate.toIso8601String();

      final response = await _client
          .from('tasks')
          .insert(data)
          .select('*, categories(*), subtasks(*), attachments(*)')
          .single();

      return TaskModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TaskModel> updateTask({
    required String id,
    required String title,
    String? description,
    String? categoryId,
    required int priority,
    required String status,
    DateTime? dueDate,
  }) async {
    try {
      final data = <String, dynamic>{
        'title': title,
        'description': description,
        'category_id': categoryId,
        'priority': priority,
        'status': status,
        'due_date': dueDate?.toIso8601String(),
      };

      final response = await _client
          .from('tasks')
          .update(data)
          .eq('id', id)
          .select('*, categories(*), subtasks(*), attachments(*)')
          .single();

      return TaskModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await _client.from('tasks').delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SubtaskModel> createSubtask({
    required String taskId,
    required String title,
  }) async {
    try {
      final countResponse = await _client
          .from('subtasks')
          .select('id')
          .eq('task_id', taskId);
      final sortOrder = (countResponse as List).length;

      final response = await _client
          .from('subtasks')
          .insert({
            'task_id': taskId,
            'title': title,
            'is_completed': false,
            'sort_order': sortOrder,
          })
          .select()
          .single();

      return SubtaskModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SubtaskModel> toggleSubtask({
    required String id,
    required bool isCompleted,
  }) async {
    try {
      final response = await _client
          .from('subtasks')
          .update({'is_completed': isCompleted})
          .eq('id', id)
          .select()
          .single();

      return SubtaskModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteSubtask(String id) async {
    try {
      await _client.from('subtasks').delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AttachmentModel> uploadAttachment({
    required String taskId,
    required String filePath,
    required String fileName,
  }) async {
    try {
      final file = File(filePath);
      final storagePath = '$taskId/$fileName';

      await _client.storage.from('attachments').upload(storagePath, file);

      final imageUrl =
          _client.storage.from('attachments').getPublicUrl(storagePath);

      final response = await _client
          .from('attachments')
          .insert({
            'task_id': taskId,
            'image_url': imageUrl,
            'file_name': storagePath,
          })
          .select()
          .single();

      return AttachmentModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteAttachment({
    required String attachmentId,
    required String storagePath,
  }) async {
    try {
      await _client.storage.from('attachments').remove([storagePath]);
      await _client.from('attachments').delete().eq('id', attachmentId);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
