import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/widgets/loader.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/core/utils/show_snackbar.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_cubit.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_state.dart';
import 'package:focus_planner/features/tasks/domain/entities/task.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_form_cubit.dart';
import 'package:focus_planner/features/tasks/presentation/cubit/task_form_state.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/date_picker_field.dart';
import 'package:focus_planner/features/tasks/presentation/widgets/priority_selector.dart';
import 'package:go_router/go_router.dart';

class TaskFormScreen extends StatefulWidget {
  final Task? task;

  const TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategoryId;
  int _priority = 0;
  DateTime? _dueDate;

  bool get _isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description ?? '';
      _selectedCategoryId = widget.task!.categoryId;
      _priority = widget.task!.priority;
      _dueDate = widget.task!.dueDate;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskFormCubit, TaskFormState>(
      listener: (context, state) {
        if (state.status == TaskFormStatus.success) {
          context.pop();
        } else if (state.status == TaskFormStatus.failure) {
          showSnackBar(context, state.errorMessage ?? 'Something went wrong');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Edit Task' : 'New Task'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Task title'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              const Text('Category',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              const SizedBox(height: 8),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  return _buildCategoryDropdown(state.categories);
                },
              ),
              const SizedBox(height: 24),
              const Text('Priority',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              const SizedBox(height: 8),
              PrioritySelector(
                selectedPriority: _priority,
                onChanged: (p) => setState(() => _priority = p),
              ),
              const SizedBox(height: 24),
              const Text('Due Date',
                  style: TextStyle(fontSize: 14, color: Colors.white70)),
              const SizedBox(height: 8),
              DatePickerField(
                selectedDate: _dueDate,
                onDateChanged: (d) => setState(() => _dueDate = d),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: BlocBuilder<TaskFormCubit, TaskFormState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.status == TaskFormStatus.loading
                          ? null
                          : _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.primaryColor,
                        foregroundColor: AppPallete.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: state.status == TaskFormStatus.loading
                          ? const ButtonLoader()
                          : Text(
                              _isEditing ? 'Save' : 'Create Task',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(List<Category> categories) {
    final validId = categories.any((c) => c.id == _selectedCategoryId)
        ? _selectedCategoryId
        : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppPallete.secondaryColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: validId,
          isExpanded: true,
          hint: const Text('Select category',
              style: TextStyle(color: Colors.white54)),
          dropdownColor: AppPallete.secondaryColor,
          items: [
            const DropdownMenuItem<String?>(
              value: null,
              child: Text('No category',
                  style: TextStyle(color: Colors.white54)),
            ),
            ...categories.map((c) => DropdownMenuItem<String?>(
                  value: c.id,
                  child: Text(c.name),
                )),
          ],
          onChanged: (value) {
            setState(() => _selectedCategoryId = value);
          },
        ),
      ),
    );
  }

  void _save() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      showSnackBar(context, 'Title is required');
      return;
    }

    final description = _descriptionController.text.trim();
    final cubit = context.read<TaskFormCubit>();

    if (_isEditing) {
      cubit.editTask(
        id: widget.task!.id,
        title: title,
        description: description.isEmpty ? null : description,
        categoryId: _selectedCategoryId,
        priority: _priority,
        status: widget.task!.status,
        dueDate: _dueDate,
      );
    } else {
      cubit.addTask(
        title: title,
        description: description.isEmpty ? null : description,
        categoryId: _selectedCategoryId,
        priority: _priority,
        dueDate: _dueDate,
      );
    }
  }
}
