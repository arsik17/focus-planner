import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppPallete.secondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (task.priority > 0) ...[
                  _buildPriorityDot(),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: task.status == 'done'
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.status == 'done'
                          ? Colors.white38
                          : Colors.white,
                    ),
                  ),
                ),
                if (task.category != null)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(int.parse(
                              task.category!.color.replaceFirst('#', '0xff')))
                          .withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      task.category!.name,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(int.parse(
                            task.category!.color.replaceFirst('#', '0xff'))),
                      ),
                    ),
                  ),
              ],
            ),
            if (task.dueDate != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 14,
                    color: _isDueToday()
                        ? AppPallete.accentColor2
                        : Colors.white38,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    DateFormat('MMM d, y').format(task.dueDate!),
                    style: TextStyle(
                      fontSize: 12,
                      color: _isDueToday()
                          ? AppPallete.accentColor2
                          : Colors.white38,
                    ),
                  ),
                ],
              ),
            ],
            if (task.subtasks.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.check_circle_outline,
                      size: 14, color: Colors.white38),
                  const SizedBox(width: 4),
                  Text(
                    '${task.subtasks.where((s) => s.isCompleted).length}/${task.subtasks.length}',
                    style:
                        const TextStyle(fontSize: 12, color: Colors.white38),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityDot() {
    Color color;
    switch (task.priority) {
      case 3:
        color = Colors.redAccent;
      case 2:
        color = Colors.orangeAccent;
      case 1:
        color = Colors.blueAccent;
      default:
        color = Colors.transparent;
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  bool _isDueToday() {
    if (task.dueDate == null) return false;
    final now = DateTime.now();
    return task.dueDate!.year == now.year &&
        task.dueDate!.month == now.month &&
        task.dueDate!.day == now.day;
  }
}
