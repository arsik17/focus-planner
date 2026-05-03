abstract class AuthRepository {
  Future<String> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<String> signIn({
    required String email,
    required String password,
  });
}
