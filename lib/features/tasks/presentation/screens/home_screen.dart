import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/shared/cubits/user/user_state.dart';
import 'package:focus_planner/core/shared/widgets/loader.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_cubit.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_state.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_state.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/category_task_section.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/greeting_header.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskListCubit>().loadTasks();
    context.read<CategoryCubit>().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserCubit>().state;
    final userName =
        userState is UserLoggedIn ? userState.user.name : 'User';

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            GreetingHeader(
              userName: userName,
              onLogout: () => context.read<AuthBloc>().add(AuthLogout()),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      final cubit = context.read<TaskListCubit>();
                      await context.push('/tasks');
                      cubit.loadTasks();
                    },
                    child: const Text(
                      'See all tasks',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppPallete.accentColor1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<TaskListCubit, TaskListState>(
                builder: (context, taskState) {
                  if (taskState.status == TaskListStatus.loading) {
                    return const Loader();
                  }

                  if (taskState.status == TaskListStatus.failure) {
                    return Center(
                      child: Text(
                        taskState.errorMessage ?? 'Something went wrong',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  return BlocBuilder<CategoryCubit, CategoryState>(
                    builder: (context, categoryState) {
                      final categories = categoryState.categories;
                      final tasks = taskState.tasks;

                      final categorizedSections = categories
                          .map((cat) {
                            final catTasks = tasks
                                .where((t) => t.categoryId == cat.id)
                                .toList();
                            return (category: cat, tasks: catTasks);
                          })
                          .where((section) => section.tasks.isNotEmpty)
                          .toList();

                      final uncategorizedTasks =
                          tasks.where((t) => t.categoryId == null).toList();

                      if (categorizedSections.isEmpty &&
                          uncategorizedTasks.isEmpty) {
                        return const Center(
                          child: Text(
                            'No tasks yet',
                            style: TextStyle(color: Colors.white38),
                          ),
                        );
                      }

                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          ...categorizedSections.map((section) =>
                              CategoryTaskSection(
                                category: section.category,
                                tasks: section.tasks,
                                onTaskTap: (task) async {
                                  final cubit =
                                      context.read<TaskListCubit>();
                                  await context.push('/tasks/${task.id}');
                                  cubit.loadTasks();
                                },
                                onStatusToggle: (task) {
                                  context
                                      .read<TaskListCubit>()
                                      .toggleTaskStatus(task);
                                },
                              )),
                          if (uncategorizedTasks.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Uncategorized',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                            ...uncategorizedTasks.take(3).map((task) =>
                                _buildUncategorizedTile(task)),
                          ],
                          const SizedBox(height: 80),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cubit = context.read<TaskListCubit>();
          await context.push('/tasks/new');
          cubit.loadTasks();
        },
        backgroundColor: AppPallete.accentColor1,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildUncategorizedTile(Task task) {
    return GestureDetector(
      onTap: () async {
        final cubit = context.read<TaskListCubit>();
        await context.push('/tasks/${task.id}');
        cubit.loadTasks();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppPallete.secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () =>
                  context.read<TaskListCubit>().toggleTaskStatus(task),
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  task.status == 'done'
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  size: 20,
                  color: task.status == 'done'
                      ? AppPallete.accentColor2
                      : Colors.white38,
                ),
              ),
            ),
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  color:
                      task.status == 'done' ? Colors.white38 : Colors.white,
                  decoration: task.status == 'done'
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white24, size: 18),
          ],
        ),
      ),
    );
  }
}
