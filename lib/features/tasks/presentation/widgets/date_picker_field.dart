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
            Expanded(
              child: Text(
                selectedDate != null
                    ? DateFormat('MMM d, y').format(selectedDate!)
                    : 'No due date',
                style: TextStyle(
                  color: selectedDate != null ? Colors.white : Colors.white54,
                ),
              ),
            ),
            if (selectedDate != null) ...[
              GestureDetector(
                onTap: () => _pickTime(context),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.access_time,
                          size: 14, color: Colors.white54),
                      const SizedBox(width: 6),
                      Text(
                        _hasTime
                            ? DateFormat('HH:mm').format(selectedDate!)
                            : 'Time',
                        style: TextStyle(
                          fontSize: 13,
                          color: _hasTime ? Colors.white : Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
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

  bool get _hasTime =>
      selectedDate != null &&
      (selectedDate!.hour != 0 || selectedDate!.minute != 0);

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _hasTime
          ? TimeOfDay.fromDateTime(selectedDate!)
          : TimeOfDay.now(),
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
    if (picked != null && selectedDate != null) {
      onDateChanged(DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        picked.hour,
        picked.minute,
      ));
    }
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
      final hour = selectedDate?.hour ?? 0;
      final minute = selectedDate?.minute ?? 0;
      onDateChanged(DateTime(
        picked.year,
        picked.month,
        picked.day,
        hour,
        minute,
      ));
    }
  }
}
