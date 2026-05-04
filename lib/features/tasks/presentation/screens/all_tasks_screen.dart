import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/widgets/loader.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_cubit.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_state.dart';
import 'package:focus_planner/features/categories/presentation/widgets/category_list.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_list_state.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/task_card.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/task_filter_bar.dart';
import 'package:go_router/go_router.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  String _selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Tasks')),
      body: Column(
        children: [
          TaskFilterBar(
            selectedStatus: _selectedStatus,
            onStatusChanged: (status) {
              setState(() => _selectedStatus = status);
            },
          ),
          const SizedBox(height: 8),
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

                var tasks = state.tasks;

                if (_selectedStatus != 'all') {
                  tasks = tasks
                      .where((t) => t.status == _selectedStatus)
                      .toList();
                }

                if (state.selectedCategoryId != null) {
                  tasks = tasks
                      .where(
                          (t) => t.categoryId == state.selectedCategoryId)
                      .toList();
                }

                if (tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      'No tasks found',
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
    );
  }
}
