import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';

class TimerDisplay extends StatelessWidget {
  final int durationSeconds;
  final CountDownController controller;
  final VoidCallback onComplete;
  final bool autoStart;

  const TimerDisplay({
    super.key,
    required this.durationSeconds,
    required this.controller,
    required this.onComplete,
    this.autoStart = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: durationSeconds,
      controller: controller,
      width: 240,
      height: 240,
      ringColor: Colors.white12,
      fillColor: AppPallete.accentColor1,
      backgroundColor: Colors.transparent,
      strokeWidth: 6.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      textFormat: CountdownTextFormat.MM_SS,
      isReverse: true,
      isReverseAnimation: false,
      autoStart: autoStart,
      onComplete: onComplete,
    );
  }
}
