import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime?> onDateChanged;

  const DatePickerField({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppPallete.secondaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18, color: Colors.white54),
            const SizedBox(width: 12),
            Text(
              selectedDate != null
                  ? DateFormat('MMM d, y').format(selectedDate!)
                  : 'No due date',
              style: TextStyle(
                color: selectedDate != null ? Colors.white : Colors.white54,
              ),
            ),
            const Spacer(),
            if (selectedDate != null)
              GestureDetector(
                onTap: () => onDateChanged(null),
                child:
                    const Icon(Icons.close, size: 18, color: Colors.white38),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppPallete.accentColor1,
              surface: AppPallete.secondaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }
}
