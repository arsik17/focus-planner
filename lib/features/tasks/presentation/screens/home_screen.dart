import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/shared/cubits/user/user_state.dart';
import 'package:focus_planner/core/shared/widgets/loader.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_cubit.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_state.dart';
import 'package:focus_planner/features/categories/presentation/widgets/category_list.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_state.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/greeting_header.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/task_card.dart';
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
            const SizedBox(height: 20),
            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, categoryState) {
                return BlocBuilder<TaskListCubit, TaskListState>(
                  builder: (context, taskState) {
                    return CategoryList(
                      categories: categoryState.categories,
                      selectedCategoryId: taskState.selectedCategoryId,
                      onCategorySelected: (id) {
                        context.read<TaskListCubit>().filterByCategory(id);
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<TaskListCubit, TaskListState>(
                builder: (context, state) {
                  if (state.status == TaskListStatus.loading) {
                    return const Loader();
                  }

                  if (state.status == TaskListStatus.failure) {
                    return Center(
                      child: Text(
                        state.errorMessage ?? 'Something went wrong',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    );
                  }

                  final today = DateTime.now();
                  var tasks = state.tasks.where((t) {
                    if (t.dueDate == null) return false;
                    return t.dueDate!.year == today.year &&
                        t.dueDate!.month == today.month &&
                        t.dueDate!.day == today.day;
                  }).toList();

                  if (state.selectedCategoryId != null) {
                    tasks = tasks
                        .where(
                            (t) => t.categoryId == state.selectedCategoryId)
                        .toList();
                  }

                  if (tasks.isEmpty) {
                    return const Center(
                      child: Text(
                        'No tasks for today',
                        style: TextStyle(color: Colors.white38),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: tasks.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return TaskCard(
                        task: tasks[index],
                        onTap: () =>
                            context.push('/tasks/${tasks[index].id}'),
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
        onPressed: () => context.push('/tasks/new'),
        backgroundColor: AppPallete.accentColor1,
        child: const Icon(Icons.add),
      ),
    );
  }
}
