import 'package:focus_planner/core/error/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<String> signIn({required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) {
        throw const ServerException('User is null after sign up.');
      }

      return response.user!.id;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException('User is null after sign in.');
      }

      return response.user!.id;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    }
  }
}
