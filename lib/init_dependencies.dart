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
import 'package:focus_planner/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:focus_planner/features/categories/data/repositories/category_repository_impl.dart';
import 'package:focus_planner/features/categories/domain/repository/category_repository.dart';
import 'package:focus_planner/features/categories/domain/use_cases/create_category.dart';
import 'package:focus_planner/features/categories/domain/use_cases/delete_category.dart';
import 'package:focus_planner/features/categories/domain/use_cases/get_categories.dart';
import 'package:focus_planner/features/categories/domain/use_cases/update_category.dart';
import 'package:focus_planner/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:focus_planner/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/create_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/delete_task.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/get_task_by_id.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/get_tasks.dart';
import 'package:focus_planner/features/tasks/domain/use_cases/update_task.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initCategories();
  _initTasks();
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

void _initCategories() {
  serviceLocator.registerFactory<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
  );

  serviceLocator.registerFactory<CategoryRepository>(
    () => CategoryRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => GetCategories(serviceLocator()));
  serviceLocator.registerFactory(() => CreateCategory(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateCategory(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteCategory(serviceLocator()));
}

void _initTasks() {
  serviceLocator.registerFactory<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(serviceLocator<SupabaseClient>()),
  );

  serviceLocator.registerFactory<TaskRepository>(
    () => TaskRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() => GetTasks(serviceLocator()));
  serviceLocator.registerFactory(() => GetTaskById(serviceLocator()));
  serviceLocator.registerFactory(() => CreateTask(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateTask(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteTask(serviceLocator()));
}
