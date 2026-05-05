import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/focus/presentation/cubit/focus_cubit.dart';
import 'package:focus_planner/features/focus/presentation/cubit/focus_state.dart';
import 'package:focus_planner/features/focus/presentation/widgets/focus_controls.dart';
import 'package:focus_planner/features/focus/presentation/widgets/timer_display.dart';
import 'package:go_router/go_router.dart';

class FocusSessionScreen extends StatefulWidget {
  final String taskId;
  final String? taskTitle;

  const FocusSessionScreen({super.key, required this.taskId, this.taskTitle});

  @override
  State<FocusSessionScreen> createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen>
    with WidgetsBindingObserver {
  int _selectedMinutes = 5;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<FocusCubit>().handleAppResumed();
    }
  }

  bool get _isSessionActive {
    final status = context.read<FocusCubit>().state.status;
    return status == FocusStatus.running || status == FocusStatus.paused;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        if (_isSessionActive) {
          _showLeaveWarning(context);
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Focus Session'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (_isSessionActive) {
                _showLeaveWarning(context);
              } else {
                context.pop();
              }
            },
          ),
        ),
        body: BlocConsumer<FocusCubit, FocusState>(
          listener: (context, state) {
            if (state.status == FocusStatus.finished) {
              final cubit = context.read<FocusCubit>();
              _showFinishedDialog(context, cubit.focusedMinutes);
            }
          },
          builder: (context, state) {
            final cubit = context.read<FocusCubit>();
            final isIdle =
                state.status == FocusStatus.initial ||
                state.status == FocusStatus.ready;

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(),
                    if (widget.taskTitle != null)
                      Text(
                        widget.taskTitle!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    const SizedBox(height: 32),
                    TimerDisplay(
                      durationSeconds: _selectedMinutes * 60,
                      controller: cubit.timerController,
                      autoStart: false,
                      onComplete: () => cubit.onTimerComplete(),
                    ),
                    const SizedBox(height: 40),
                    if (isIdle) _buildDurationPicker(),
                    if (!isIdle && state.status != FocusStatus.finished)
                      Text(
                        state.status == FocusStatus.paused
                            ? 'Paused'
                            : 'Stay focused...',
                        style: TextStyle(
                          fontSize: 16,
                          color: state.status == FocusStatus.paused
                              ? Colors.amber
                              : Colors.white38,
                        ),
                      ),
                    const SizedBox(height: 40),
                    FocusControls(
                      status: state.status,
                      onStart: () {
                        cubit.setDuration(_selectedMinutes);
                        cubit.startSession();
                      },
                      onPause: cubit.pauseSession,
                      onResume: cubit.resumeSession,
                      onStop: cubit.stopSession,
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDurationPicker() {
    final options = [5, 10, 15, 20, 30, 45, 60];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: options.map((min) {
          final isSelected = _selectedMinutes == min;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => setState(() => _selectedMinutes = min),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppPallete.accentColor1.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppPallete.accentColor1
                        : Colors.white24,
                  ),
                ),
                child: Text(
                  '${min}m',
                  style: TextStyle(
                    color: isSelected
                        ? AppPallete.accentColor1
                        : Colors.white54,
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showFinishedDialog(BuildContext context, int focusedMinutes) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppPallete.secondaryColor,
        title: const Text('Session Complete!'),
        content: Text(
          'You focused for $focusedMinutes ${focusedMinutes == 1 ? 'minute' : 'minutes'}. Great job!',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.pop();
            },
            child: const Text(
              'Done',
              style: TextStyle(color: AppPallete.accentColor1),
            ),
          ),
        ],
      ),
    );
  }

  void _showLeaveWarning(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppPallete.secondaryColor,
        title: const Text('Leave Session?'),
        content: const Text(
          'Your focus timer will be lost if you leave now.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Stay'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<FocusCubit>().stopSession();
              context.pop();
            },
            child: const Text(
              'Leave',
              style: TextStyle(color: AppPallete.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
