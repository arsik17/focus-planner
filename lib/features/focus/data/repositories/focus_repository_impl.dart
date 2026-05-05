import 'package:focus_planner/features/focus/data/datasources/focus_remote_data_source.dart';
import 'package:focus_planner/features/focus/domain/entities/focus_session.dart';
import 'package:focus_planner/features/focus/domain/repository/focus_repository.dart';

class FocusRepositoryImpl implements FocusRepository {
  final FocusRemoteDataSource _remoteDataSource;

  FocusRepositoryImpl(this._remoteDataSource);

  @override
  Future<FocusSession> createSession({
    required String taskId,
    required int durationMinutes,
    required DateTime startedAt,
  }) async {
    final model = await _remoteDataSource.createSession(
      taskId: taskId,
      durationMinutes: durationMinutes,
      startedAt: startedAt,
    );
    return model.toEntity();
  }

  @override
  Future<FocusSession> endSession({
    required String id,
    required DateTime endedAt,
  }) async {
    final model = await _remoteDataSource.endSession(
      id: id,
      endedAt: endedAt,
    );
    return model.toEntity();
  }

  @override
  Future<List<FocusSession>> getSessions() async {
    final models = await _remoteDataSource.getSessions();
    return models.map((m) => m.toEntity()).toList();
  }
}
