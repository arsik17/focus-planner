import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/tasks/domain/entities/subtask.dart';

class SubtaskTile extends StatelessWidget {
  final Subtask subtask;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const SubtaskTile({
    super.key,
    required this.subtask,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppPallete.secondaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                subtask.isCompleted
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                key: ValueKey(subtask.isCompleted),
                size: 22,
                color: subtask.isCompleted
                    ? AppPallete.accentColor2
                    : Colors.white38,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              subtask.title,
              style: TextStyle(
                color: subtask.isCompleted ? Colors.white38 : Colors.white,
                decoration:
                    subtask.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.close, size: 16, color: Colors.white24),
            ),
          ),
        ],
      ),
    );
  }
}
