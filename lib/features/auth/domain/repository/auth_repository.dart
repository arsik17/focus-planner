import 'package:focus_planner/core/shared/entities/user.dart';

abstract class AuthRepository {
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<User> signIn({required String email, required String password});

  Future<User?> getCurrentUser();

  Future<void> logout();
}
