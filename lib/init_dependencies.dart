import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:focus_planner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:focus_planner/features/auth/domain/repository/auth_repository.dart';
import 'package:focus_planner/features/auth/domain/use_cases/current_user.dart';
import 'package:focus_planner/features/auth/domain/use_cases/logout.dart';
import 'package:focus_planner/features/auth/domain/use_cases/user_sign_in.dart';
import 'package:focus_planner/features/auth/domain/use_cases/user_sign_up.dart';
import 'package:focus_planner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  await dotenv.load();

  final supabase = await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignIn(serviceLocator()));

  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));

  serviceLocator.registerFactory(() => Logout(serviceLocator()));

  serviceLocator.registerLazySingleton(() => UserCubit());

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      logout: serviceLocator(),
      userCubit: serviceLocator(),
    ),
  );
}
