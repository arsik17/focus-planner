import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/shared/cubits/user/user_state.dart';
import 'package:focus_planner/core/shared/widgets/loader.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_cubit.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_state.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_state.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/category_task_section.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/greeting_header.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/today_tasks_section.dart';
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
            GreetingHeader(userName: userName),
            const SizedBox(height: 16),
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

                      final now = DateTime.now();
                      final todayTasks = tasks.where((t) {
                        if (t.dueDate == null) return false;
                        return t.dueDate!.year == now.year &&
                            t.dueDate!.month == now.month &&
                            t.dueDate!.day == now.day;
                      }).toList();

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
                          uncategorizedTasks.isEmpty &&
                          todayTasks.isEmpty) {
                        return const Center(
                          child: Text(
                            'No tasks yet',
                            style: TextStyle(color: Colors.white38),
                          ),
                        );
                      }

                      return ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          if (todayTasks.isNotEmpty) ...[
                            TodayTasksSection(
                              tasks: todayTasks,
                              onTaskTap: (task) async {
                                final cubit =
                                    context.read<TaskListCubit>();
                                await context.push('/tasks/${task.id}');
                                cubit.loadTasks();
                              },
                              onComplete: (task) {
                                context
                                    .read<TaskListCubit>()
                                    .toggleTaskStatus(task);
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                          if (categorizedSections.isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                          ...categorizedSections.map((section) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16),
                                child: CategoryTaskSection(
                                  category: section.category,
                                  tasks: section.tasks,
                                  onTaskTap: (task) async {
                                    final cubit =
                                        context.read<TaskListCubit>();
                                    await context
                                        .push('/tasks/${task.id}');
                                    cubit.loadTasks();
                                  },
                                  onStatusToggle: (task) {
                                    context
                                        .read<TaskListCubit>()
                                        .toggleTaskStatus(task);
                                  },
                                  onChevronTap: () {
                                    context.go(
                                      '/tasks?categoryId=${section.category.id}',
                                    );
                                  },
                                ),
                              )),
                          if (uncategorizedTasks.isNotEmpty) ...[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 8),
                              child: Text(
                                'Uncategorized',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Colors.white.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                            ...uncategorizedTasks.take(3).map((task) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child:
                                      _buildUncategorizedTile(task),
                                )),
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
