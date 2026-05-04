import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/shared/cubits/user/user_state.dart';
import 'package:focus_planner/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:focus_planner/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_cubit.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_detail_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_form_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/screens/all_tasks_screen.dart';
import 'package:focus_planner/features/tasks/presentation/screens/home_screen.dart';
import 'package:focus_planner/features/tasks/presentation/screens/task_detail_screen.dart';
import 'package:focus_planner/features/tasks/presentation/screens/task_form_screen.dart';
import 'package:focus_planner/init_dependencies.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final UserCubit userCubit;

  AppRouter({required this.userCubit});

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(userCubit.stream),
    redirect: (context, state) {
      final isLoggedIn = userCubit.state is UserLoggedIn;
      final isAuthRoute = state.matchedLocation == '/sign-in' ||
          state.matchedLocation == '/sign-up';

      if (!isLoggedIn && !isAuthRoute) return '/sign-in';
      if (isLoggedIn && isAuthRoute) return '/';

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => TaskListCubit(
                getTasks: serviceLocator(),
                deleteTask: serviceLocator(),
              ),
            ),
            BlocProvider(
              create: (_) => CategoryCubit(
                getCategories: serviceLocator(),
                createCategory: serviceLocator(),
                updateCategory: serviceLocator(),
                deleteCategory: serviceLocator(),
              ),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/tasks',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => TaskListCubit(
                getTasks: serviceLocator(),
                deleteTask: serviceLocator(),
              )..loadTasks(),
            ),
            BlocProvider(
              create: (_) => CategoryCubit(
                getCategories: serviceLocator(),
                createCategory: serviceLocator(),
                updateCategory: serviceLocator(),
                deleteCategory: serviceLocator(),
              )..loadCategories(),
            ),
          ],
          child: const AllTasksScreen(),
        ),
      ),
      GoRoute(
        path: '/tasks/new',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => TaskFormCubit(
                createTask: serviceLocator(),
                updateTask: serviceLocator(),
              ),
            ),
            BlocProvider(
              create: (_) => CategoryCubit(
                getCategories: serviceLocator(),
                createCategory: serviceLocator(),
                updateCategory: serviceLocator(),
                deleteCategory: serviceLocator(),
              )..loadCategories(),
            ),
          ],
          child: const TaskFormScreen(),
        ),
      ),
      GoRoute(
        path: '/tasks/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return BlocProvider(
            create: (_) => TaskDetailCubit(
              getTaskById: serviceLocator(),
              updateTask: serviceLocator(),
              deleteTask: serviceLocator(),
            ),
            child: TaskDetailScreen(taskId: id),
          );
        },
      ),
      GoRoute(
        path: '/tasks/:id/edit',
        builder: (context, state) {
          final task = state.extra as Task?;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => TaskFormCubit(
                  createTask: serviceLocator(),
                  updateTask: serviceLocator(),
                ),
              ),
              BlocProvider(
                create: (_) => CategoryCubit(
                  getCategories: serviceLocator(),
                  createCategory: serviceLocator(),
                  updateCategory: serviceLocator(),
                  deleteCategory: serviceLocator(),
                )..loadCategories(),
              ),
            ],
            child: TaskFormScreen(task: task),
          );
        },
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
