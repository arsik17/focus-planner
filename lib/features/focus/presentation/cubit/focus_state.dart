import 'package:freezed_annotation/freezed_annotation.dart';

part 'focus_state.freezed.dart';

enum FocusStatus { initial, ready, running, paused, finished, failure }

@freezed
abstract class FocusState with _$FocusState {
  const factory FocusState({
    @Default(FocusStatus.initial) FocusStatus status,
    @Default(25) int totalMinutes,
    String? sessionId,
    DateTime? startedAt,
    DateTime? pausedAt,
    @Default(0) int pausedElapsed,
    String? errorMessage,
  }) = _FocusState;
}
