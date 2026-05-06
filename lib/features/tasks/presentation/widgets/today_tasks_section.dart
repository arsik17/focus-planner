import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:intl/intl.dart';

class TodayTasksSection extends StatelessWidget {
  final List<Task> tasks;
  final ValueChanged<Task> onTaskTap;
  final ValueChanged<Task> onComplete;

  const TodayTasksSection({
    super.key,
    required this.tasks,
    required this.onTaskTap,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Today',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: tasks.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _buildCard(tasks[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(Task task) {
    final isDone = task.status == 'done';
    final dueDateText = task.dueDate != null
        ? DateFormat('MMM d, h:mm a').format(task.dueDate!)
        : null;

    final categoryColor = task.category != null
        ? Color(int.parse(task.category!.color.replaceFirst('#', '0xff')))
        : AppPallete.accentColor1;

    final totalSubtasks = task.subtasks.length;
    final completedSubtasks =
        task.subtasks.where((s) => s.isCompleted).length;
    final progress =
        totalSubtasks > 0 ? completedSubtasks / totalSubtasks : 0.0;

    return GestureDetector(
      onTap: () => onTaskTap(task),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppPallete.secondaryColor,
          borderRadius: BorderRadius.circular(16),
          border: Border(
            top: BorderSide(color: categoryColor, width: 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.category != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  task.category!.name,
                  style: TextStyle(
                    fontSize: 11,
                    color: categoryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                if (task.priority > 0) ...[
                  _buildPriorityDot(task.priority),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDone ? Colors.white38 : Colors.white,
                      decoration:
                          isDone ? TextDecoration.lineThrough : null,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (totalSubtasks > 0) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 4,
                        backgroundColor:
                            Colors.white.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppPallete.accentColor2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$completedSubtasks/$totalSubtasks',
                    style: const TextStyle(
                        fontSize: 11, color: Colors.white54),
                  ),
                ],
              ),
            ],
            const Spacer(),
            if (dueDateText != null) ...[
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 14, color: Colors.white54),
                  const SizedBox(width: 4),
                  Text(
                    dueDateText,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.white54),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            GestureDetector(
              onTap: () => onComplete(task),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  color: isDone
                      ? AppPallete.accentColor2.withValues(alpha: 0.2)
                      : AppPallete.accentColor1.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    isDone ? 'Done' : 'Complete',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDone
                          ? AppPallete.accentColor2
                          : AppPallete.accentColor1,
                    ),
                  ),
                ),
              ),
            ),
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
