import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/tasks/domain/entities/subtask.dart';
import 'package:focus_planner/features/tasks/domain/entities/attachment.dart';

class Task {
  final String id;
  final String userId;
  final String? categoryId;
  final String title;
  final String? description;
  final int priority;
  final String status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category? category;
  final List<Subtask> subtasks;
  final List<Attachment> attachments;

  Task({
    required this.id,
    required this.userId,
    this.categoryId,
    required this.title,
    this.description,
    required this.priority,
    required this.status,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.category,
    this.subtasks = const [],
    this.attachments = const [],
  });
}
