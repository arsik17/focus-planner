import 'package:flutter/material.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/categories/presentation/widgets/category_chip.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length + 1,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () => onCategorySelected(null),
              child: Chip(
                label: const Text('All'),
                backgroundColor: selectedCategoryId == null
                    ? Colors.white24
                    : Colors.transparent,
                side: const BorderSide(color: Colors.white24),
                labelStyle: const TextStyle(color: Colors.white70),
              ),
            );
          }

          final category = categories[index - 1];
          return CategoryChip(
            category: category,
            isSelected: selectedCategoryId == category.id,
            onTap: () => onCategorySelected(category.id),
          );
        },
      ),
    );
  }
}
