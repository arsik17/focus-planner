import 'package:focus_planner/core/error/server_exception.dart';
import 'package:focus_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:focus_planner/core/shared/entities/user.dart';
import 'package:focus_planner/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await _remoteDataSource.signUp(
        name: name,
        email: email,
        password: password,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<User> signIn({required String email, required String password}) async {
    try {
      return await _remoteDataSource.signIn(email: email, password: password);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      return await _remoteDataSource.getCurrentUserData();
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      return await _remoteDataSource.logout();
    } on ServerException {
      rethrow;
    }
  }
}
