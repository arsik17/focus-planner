import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/theme/app_pallete.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_cubit.dart';

class CategoryFormScreen extends StatefulWidget {
  final Category? category;

  const CategoryFormScreen({super.key, this.category});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _nameController = TextEditingController();
  String _selectedColor = '#8D5BBD';
  String _selectedIcon = 'category';

  final _colors = [
    '#4A9A86',
    '#8D5BBD',
    '#E6A23C',
    '#F56C6C',
    '#409EFF',
    '#67C23A',
  ];

  final _icons = {
    'work': Icons.work_outline,
    'person': Icons.person_outline,
    'school': Icons.school_outlined,
    'favorite': Icons.favorite_outline,
    'category': Icons.category_outlined,
    'fitness_center': Icons.fitness_center,
    'code': Icons.code,
    'music_note': Icons.music_note,
  };

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _selectedColor = widget.category!.color;
      _selectedIcon = widget.category!.icon;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.category != null;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isEditing ? 'Edit Category' : 'New Category',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Category name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Color', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _colors.map((color) {
              final c = Color(int.parse(color.replaceFirst('#', '0xff')));
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = color),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: c,
                  child: _selectedColor == color
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          const Text('Icon', style: TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _icons.entries.map((entry) {
              final isSelected = _selectedIcon == entry.key;
              return GestureDetector(
                onTap: () => setState(() => _selectedIcon = entry.key),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      isSelected ? Colors.white24 : Colors.transparent,
                  child: Icon(
                    entry.value,
                    color: isSelected ? Colors.white : Colors.white54,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPallete.primaryColor,
                foregroundColor: AppPallete.secondaryColor,
              ),
              child: Text(isEditing ? 'Save' : 'Create'),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final cubit = context.read<CategoryCubit>();

    if (widget.category != null) {
      cubit.editCategory(
        id: widget.category!.id,
        name: name,
        color: _selectedColor,
        icon: _selectedIcon,
      );
    } else {
      cubit.addCategory(
        name: name,
        color: _selectedColor,
        icon: _selectedIcon,
      );
    }

    Navigator.pop(context);
  }
}
