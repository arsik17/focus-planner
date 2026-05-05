import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/features/focus/domain/use_cases/create_focus_session.dart';
import 'package:focus_planner/features/focus/domain/use_cases/end_focus_session.dart';
import 'package:focus_planner/features/focus/presentation/cubit/focus_state.dart';

class FocusCubit extends Cubit<FocusState> {
  final CreateFocusSession _createFocusSession;
  final EndFocusSession _endFocusSession;
  final String taskId;

  final CountDownController timerController = CountDownController();

  FocusCubit({
    required CreateFocusSession createFocusSession,
    required EndFocusSession endFocusSession,
    required this.taskId,
  })  : _createFocusSession = createFocusSession,
        _endFocusSession = endFocusSession,
        super(const FocusState());

  void setDuration(int minutes) {
    emit(state.copyWith(totalMinutes: minutes, status: FocusStatus.ready));
  }

  Future<void> startSession() async {
    try {
      final now = DateTime.now();
      final session = await _createFocusSession(CreateFocusSessionParams(
        taskId: taskId,
        durationMinutes: state.totalMinutes,
        startedAt: now,
      ));

      emit(state.copyWith(
        status: FocusStatus.running,
        sessionId: session.id,
        startedAt: now,
        pausedElapsed: 0,
      ));

      timerController.start();
    } catch (e) {
      emit(state.copyWith(
        status: FocusStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void pauseSession() {
    timerController.pause();
    emit(state.copyWith(
      status: FocusStatus.paused,
      pausedAt: DateTime.now(),
    ));
  }

  void resumeSession() {
    final pauseDuration = state.pausedAt != null
        ? DateTime.now().difference(state.pausedAt!).inSeconds
        : 0;

    timerController.resume();
    emit(state.copyWith(
      status: FocusStatus.running,
      pausedElapsed: state.pausedElapsed + pauseDuration,
      pausedAt: null,
    ));
  }

  int get elapsedSeconds {
    if (state.startedAt == null) return 0;
    final total = DateTime.now().difference(state.startedAt!).inSeconds;
    final paused = state.pausedElapsed;
    if (state.pausedAt != null) {
      return total - paused - DateTime.now().difference(state.pausedAt!).inSeconds;
    }
    return total - paused;
  }

  int get focusedMinutes => (elapsedSeconds / 60).ceil().clamp(1, state.totalMinutes);

  int get remainingSecondsFromTime {
    final totalSec = state.totalMinutes * 60;
    final remaining = totalSec - elapsedSeconds;
    return remaining > 0 ? remaining : 0;
  }

  Future<void> stopSession() async {
    timerController.pause();

    if (state.sessionId == null) return;

    try {
      await _endFocusSession(EndFocusSessionParams(
        id: state.sessionId!,
        endedAt: DateTime.now(),
      ));

      emit(state.copyWith(status: FocusStatus.finished));
    } catch (e) {
      emit(state.copyWith(
        status: FocusStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> onTimerComplete() async {
    if (state.sessionId == null) return;

    try {
      await _endFocusSession(EndFocusSessionParams(
        id: state.sessionId!,
        endedAt: DateTime.now(),
      ));

      emit(state.copyWith(status: FocusStatus.finished));
    } catch (e) {
      emit(state.copyWith(
        status: FocusStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void handleAppResumed() {
    if (state.status != FocusStatus.running) return;

    final remaining = remainingSecondsFromTime;
    if (remaining <= 0) {
      onTimerComplete();
    }
  }
}
