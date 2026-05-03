import 'package:focus_planner/core/error/server_exception.dart';
import 'package:focus_planner/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signIn({required String email, required String password});

  Future<UserModel?> getCurrentUserData();

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Session? get currentUserSession => _client.auth.currentSession;

  @override
  Future<UserModel> signUp({
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

      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException('Error signing in!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final supabaseUser = currentUserSession!.user;
        final profileList = await _client
            .from('profiles')
            .select()
            .eq('id', supabaseUser.id);

        return UserModel(
          id: supabaseUser.id,
          email: profileList.first['email'] ?? '',
          name: profileList.first['name'] ?? '',
        );
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
