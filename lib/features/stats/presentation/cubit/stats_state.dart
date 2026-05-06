import 'package:freezed_annotation/freezed_annotation.dart';

part 'stats_state.freezed.dart';

enum StatsStatus { initial, loading, success, failure }

@freezed
abstract class StatsState with _$StatsState {
  const factory StatsState({
    @Default(StatsStatus.initial) StatsStatus status,
    @Default(0) int totalTasks,
    @Default(0) int completedTasks,
    @Default(0) int totalFocusMinutes,
    @Default(0) int totalSessions,
    @Default(0) int currentStreak,
    @Default('') String topCategoryName,
    @Default(0) int topCategoryTaskCount,
    @Default({}) Map<String, int> weeklyFocusMinutes,
    String? errorMessage,
  }) = _StatsState;
}
