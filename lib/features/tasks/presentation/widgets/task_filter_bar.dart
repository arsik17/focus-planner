import 'package:flutter/material.dart';

class TaskFilterBar extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusChanged;

  const TaskFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildChip('all', 'All'),
          const SizedBox(width: 8),
          _buildChip('todo', 'To Do'),
          const SizedBox(width: 8),
          _buildChip('in_progress', 'In Progress'),
          const SizedBox(width: 8),
          _buildChip('done', 'Done'),
        ],
      ),
    );
  }

  Widget _buildChip(String value, String label) {
    final isSelected = selectedStatus == value;

    return GestureDetector(
      onTap: () => onStatusChanged(value),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.white24 : Colors.transparent,
        side: BorderSide(
          color: isSelected ? Colors.white54 : Colors.white24,
        ),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.white54,
          fontSize: 13,
        ),
      ),
    );
  }
}
