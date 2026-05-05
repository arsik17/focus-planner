import 'package:focus_planner/core/error/server_exception.dart';
import 'package:focus_planner/features/focus/data/models/focus_session_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class FocusRemoteDataSource {
  Future<FocusSessionModel> createSession({
    required String taskId,
    required int durationMinutes,
    required DateTime startedAt,
  });
  Future<FocusSessionModel> endSession({
    required String id,
    required DateTime endedAt,
  });
  Future<List<FocusSessionModel>> getSessions();
}

class FocusRemoteDataSourceImpl implements FocusRemoteDataSource {
  final SupabaseClient _client;

  FocusRemoteDataSourceImpl(this._client);

  @override
  Future<FocusSessionModel> createSession({
    required String taskId,
    required int durationMinutes,
    required DateTime startedAt,
  }) async {
    try {
      final userId = _client.auth.currentUser!.id;
      final response = await _client.from('focus_sessions').insert({
        'user_id': userId,
        'task_id': taskId,
        'duration_minutes': durationMinutes,
        'started_at': startedAt.toIso8601String(),
      }).select().single();

      return FocusSessionModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<FocusSessionModel> endSession({
    required String id,
    required DateTime endedAt,
  }) async {
    try {
      final response = await _client.from('focus_sessions').update({
        'ended_at': endedAt.toIso8601String(),
      }).eq('id', id).select().single();

      return FocusSessionModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FocusSessionModel>> getSessions() async {
    try {
      final response = await _client
          .from('focus_sessions')
          .select()
          .order('started_at', ascending: false);

      return (response as List)
          .map((json) => FocusSessionModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
