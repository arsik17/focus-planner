import 'package:flutter/material.dart';

class PrioritySelector extends StatelessWidget {
  final int selectedPriority;
  final ValueChanged<int> onChanged;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildOption(0, 'None', Colors.white38),
        const SizedBox(width: 8),
        _buildOption(1, 'Low', Colors.blueAccent),
        const SizedBox(width: 8),
        _buildOption(2, 'Medium', Colors.orangeAccent),
        const SizedBox(width: 8),
        _buildOption(3, 'High', Colors.redAccent),
      ],
    );
  }

  Widget _buildOption(int value, String label, Color color) {
    final isSelected = selectedPriority == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? color : Colors.white24,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected ? color : Colors.white54,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
