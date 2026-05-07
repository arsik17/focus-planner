import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';

class CategoryTaskSection extends StatelessWidget {
  final Category category;
  final List<Task> tasks;
  final ValueChanged<Task> onTaskTap;
  final ValueChanged<Task> onStatusToggle;
  final VoidCallback? onChevronTap;

  const CategoryTaskSection({
    super.key,
    required this.category,
    required this.tasks,
    required this.onTaskTap,
    required this.onStatusToggle,
    this.onChevronTap,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor =
        Color(int.parse(category.color.replaceFirst('#', '0xff')));

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          GestureDetector(
            onTap: onChevronTap,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right,
                      color: Colors.white54, size: 20),
                ],
              ),
            ),
          ),
          ...tasks.take(3).map((task) => _buildTaskTile(task)),
        ],
      ),
    );
  }

  Widget _buildTaskTile(Task task) {
    final totalSubtasks = task.subtasks.length;
    final completedSubtasks =
        task.subtasks.where((s) => s.isCompleted).length;
    final progress =
        totalSubtasks > 0 ? completedSubtasks / totalSubtasks : 0.0;
    final isDone = task.status == 'done';

    return GestureDetector(
      onTap: () => onTaskTap(task),
      child: Container(
        margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppPallete.secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => onStatusToggle(task),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      isDone ? Icons.check_circle : Icons.circle_outlined,
                      size: 18,
                      color: isDone ? AppPallete.accentColor2 : Colors.white38,
                    ),
                  ),
                ),
                if (task.priority > 0) ...[
                  _buildPriorityDot(task.priority),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDone ? Colors.white38 : Colors.white,
                      decoration:
                          isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                if (totalSubtasks > 0)
                  Text(
                    '$completedSubtasks/$totalSubtasks',
                    style:
                        const TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                if (totalSubtasks == 0)
                  const Icon(Icons.chevron_right,
                      color: Colors.white24, size: 18),
              ],
            ),
            if (totalSubtasks > 0) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 4,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppPallete.accentColor2),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityDot(int priority) {
    Color color;
    switch (priority) {
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
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
