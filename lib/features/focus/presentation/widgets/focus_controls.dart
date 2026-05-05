import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/focus/presentation/cubit/focus_state.dart';

class FocusControls extends StatelessWidget {
  final FocusStatus status;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onStop;

  const FocusControls({
    super.key,
    required this.status,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    if (status == FocusStatus.ready || status == FocusStatus.initial) {
      return _buildButton(
        label: 'Start',
        icon: Icons.play_arrow_rounded,
        color: AppPallete.accentColor1,
        onTap: onStart,
      );
    }

    if (status == FocusStatus.running) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(
            label: 'Pause',
            icon: Icons.pause_rounded,
            color: Colors.amber,
            onTap: onPause,
          ),
          const SizedBox(width: 24),
          _buildButton(
            label: 'Stop',
            icon: Icons.stop_rounded,
            color: AppPallete.errorColor,
            onTap: onStop,
          ),
        ],
      );
    }

    if (status == FocusStatus.paused) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(
            label: 'Resume',
            icon: Icons.play_arrow_rounded,
            color: AppPallete.accentColor2,
            onTap: onResume,
          ),
          const SizedBox(width: 24),
          _buildButton(
            label: 'Stop',
            icon: Icons.stop_rounded,
            color: AppPallete.errorColor,
            onTap: onStop,
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
