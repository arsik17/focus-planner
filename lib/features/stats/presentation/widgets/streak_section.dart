import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';

class StreakSection extends StatelessWidget {
  final int currentStreak;
  final int totalSessions;
  final int totalMinutes;

  const StreakSection({
    super.key,
    required this.currentStreak,
    required this.totalSessions,
    required this.totalMinutes,
  });

  String _formatTime(int minutes) {
    if (minutes < 60) return '$minutes min';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m > 0 ? '${h}h ${m}m' : '${h}h';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Focus Stats',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        _buildRow('Current Streak', '$currentStreak ${currentStreak == 1 ? 'Day' : 'Days'}'),
        const SizedBox(height: 10),
        _buildRow('Total Sessions', '$totalSessions'),
        const SizedBox(height: 10),
        _buildRow('Total Focus Time', _formatTime(totalMinutes)),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: AppPallete.accentColor2,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white70,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
