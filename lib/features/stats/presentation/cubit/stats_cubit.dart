import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/focus/domain/entities/focus_session.dart';
import 'package:focus_planner/features/focus/domain/use_cases/get_focus_sessions.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:focus_planner/features/stats/presentation/cubit/stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  final GetTasks _getTasks;
  final GetFocusSessions _getFocusSessions;

  StatsCubit({
    required GetTasks getTasks,
    required GetFocusSessions getFocusSessions,
  })  : _getTasks = getTasks,
        _getFocusSessions = getFocusSessions,
        super(const StatsState());

  Future<void> loadStats() async {
    emit(state.copyWith(status: StatsStatus.loading));

    try {
      final tasks = await _getTasks(NoParams());
      final sessions = await _getFocusSessions(NoParams());

      final totalTasks = tasks.length;
      final completedTasks = tasks.where((t) => t.status == 'done').length;

      final totalMinutes = sessions.fold<int>(
        0,
        (sum, s) => sum + s.durationMinutes,
      );

      final streak = _calculateStreak(sessions);
      final topCategory = _findTopCategory(tasks);
      final weeklyMinutes = _calculateWeeklyFocus(sessions);

      emit(state.copyWith(
        status: StatsStatus.success,
        totalTasks: totalTasks,
        completedTasks: completedTasks,
        totalFocusMinutes: totalMinutes,
        totalSessions: sessions.length,
        currentStreak: streak,
        topCategoryName: topCategory.$1,
        topCategoryTaskCount: topCategory.$2,
        weeklyFocusMinutes: weeklyMinutes,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: StatsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  int _calculateStreak(List<FocusSession> sessions) {
    if (sessions.isEmpty) return 0;

    final sessionDays = sessions
        .where((s) => s.endedAt != null)
        .map((s) => DateTime(s.startedAt.year, s.startedAt.month, s.startedAt.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    if (sessionDays.isEmpty) return 0;

    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final diff = today.difference(sessionDays.first).inDays;
    if (diff > 1) return 0;

    int streak = 1;
    for (int i = 1; i < sessionDays.length; i++) {
      final dayDiff = sessionDays[i - 1].difference(sessionDays[i]).inDays;
      if (dayDiff == 1) {
        streak++;
      } else {
        break;
      }
    }

    return streak;
  }

  (String, int) _findTopCategory(List<Task> tasks) {
    if (tasks.isEmpty) return ('', 0);

    final counts = <String, int>{};
    final names = <String, String>{};

    for (final task in tasks) {
      if (task.category != null) {
        final id = task.category!.id;
        counts[id] = (counts[id] ?? 0) + 1;
        names[id] = task.category!.name;
      }
    }

    if (counts.isEmpty) return ('', 0);

    final topId = counts.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
    return (names[topId]!, counts[topId]!);
  }

  Map<String, int> _calculateWeeklyFocus(List<FocusSession> sessions) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);

    final labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final weekly = <String, int>{for (final l in labels) l: 0};

    for (final session in sessions) {
      if (session.endedAt == null) continue;
      final day = DateTime(
        session.startedAt.year,
        session.startedAt.month,
        session.startedAt.day,
      );
      if (day.isBefore(startOfWeek)) continue;
      if (day.isAfter(now)) continue;

      final dayIndex = session.startedAt.weekday - 1;
      final label = labels[dayIndex];
      weekly[label] = weekly[label]! + session.durationMinutes;
    }

    return weekly;
  }
}
