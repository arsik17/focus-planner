import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/widgets/loader.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_detail_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_detail_state.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/subtask_input.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/subtask_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskDetailCubit>().loadTask(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<TaskDetailCubit, TaskDetailState>(
            builder: (context, state) {
              if (state.task == null) return const SizedBox.shrink();
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => context.push(
                          '/tasks/${state.task!.id}/edit',
                          extra: state.task,
                        ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _confirmDelete(context),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskDetailCubit, TaskDetailState>(
        builder: (context, state) {
          if (state.status == TaskDetailStatus.loading) {
            return const Loader();
          }

          if (state.status == TaskDetailStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Something went wrong',
                style: const TextStyle(color: Colors.white54),
              ),
            );
          }

          final task = state.task;
          if (task == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildStatusChips(task),
                const SizedBox(height: 20),
                _buildInfoRow(
                    Icons.flag_outlined, 'Priority', _priorityLabel(task.priority)),
                if (task.category != null)
                  _buildInfoRow(
                      Icons.category_outlined, 'Category', task.category!.name),
                if (task.dueDate != null)
                  _buildInfoRow(Icons.calendar_today, 'Due Date',
                      DateFormat('MMM d, y').format(task.dueDate!)),
                if (task.description != null &&
                    task.description!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  const Text('Description',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text(
                    task.description!,
                    style:
                        const TextStyle(fontSize: 15, color: Colors.white60),
                  ),
                ],
                const SizedBox(height: 24),
                Text(
                  'Subtasks${task.subtasks.isNotEmpty ? ' (${task.subtasks.where((s) => s.isCompleted).length}/${task.subtasks.length})' : ''}',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white70),
                ),
                const SizedBox(height: 8),
                ...task.subtasks.map((subtask) => SubtaskTile(
                      subtask: subtask,
                      onToggle: () => context
                          .read<TaskDetailCubit>()
                          .toggleSubtaskStatus(
                              subtask.id, !subtask.isCompleted),
                      onDelete: () => context
                          .read<TaskDetailCubit>()
                          .removeSubtask(subtask.id),
                    )),
                SubtaskInput(
                  onSubmit: (title) =>
                      context.read<TaskDetailCubit>().addSubtask(title),
                ),
                if (task.attachments.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text('Attachments',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70)),
                  const SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: task.attachments.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          task.attachments[index].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ],
                const SizedBox(height: 32),
                if (task.status != 'done')
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          context.push('/focus/${task.id}'),
                      icon: const Icon(Icons.timer_outlined),
                      label: const Text('Start Focus Session'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.accentColor1,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusChips(Task task) {
    final statuses = ['todo', 'in_progress', 'done'];
    final labels = {
      'todo': 'To Do',
      'in_progress': 'In Progress',
      'done': 'Done',
    };
    final colors = {
      'todo': Colors.blueAccent,
      'in_progress': Colors.amber,
      'done': AppPallete.accentColor2,
    };

    return Row(
      children: statuses.map((s) {
        final isSelected = task.status == s;
        final chipColor = colors[s]!;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () {
              if (!isSelected) {
                context.read<TaskDetailCubit>().updateStatus(s);
              }
            },
            child: Chip(
              label: Text(labels[s]!),
              backgroundColor: isSelected
                  ? chipColor.withValues(alpha: 0.2)
                  : Colors.transparent,
              side: BorderSide(
                color: isSelected ? chipColor : Colors.white24,
              ),
              labelStyle: TextStyle(
                color: isSelected ? chipColor : Colors.white54,
                fontSize: 13,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white38),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white38)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  String _priorityLabel(int priority) {
    switch (priority) {
      case 3:
        return 'High';
      case 2:
        return 'Medium';
      case 1:
        return 'Low';
      default:
        return 'None';
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppPallete.secondaryColor,
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<TaskDetailCubit>().removeTask();
              context.pop();
            },
            child: const Text('Delete',
                style: TextStyle(color: AppPallete.errorColor)),
          ),
        ],
      ),
    );
  }
}
