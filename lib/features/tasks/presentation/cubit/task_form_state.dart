import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_form_state.freezed.dart';

enum TaskFormStatus { initial, loading, success, failure }

@freezed
abstract class TaskFormState with _$TaskFormState {
  const factory TaskFormState({
    @Default(TaskFormStatus.initial) TaskFormStatus status,
    String? errorMessage,
  }) = _TaskFormState;
}
