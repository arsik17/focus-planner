import 'package:flutter/material.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';

class CategoryChip extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(category.color.replaceFirst('#', '0xff')));

    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(category.name),
        avatar: Icon(
          _getIcon(category.icon),
          size: 18,
          color: isSelected ? Colors.white : color,
        ),
        backgroundColor: isSelected ? color : Colors.transparent,
        side: BorderSide(color: color),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'work':
        return Icons.work_outline;
      case 'person':
        return Icons.person_outline;
      case 'school':
        return Icons.school_outlined;
      case 'favorite':
        return Icons.favorite_outline;
      default:
        return Icons.category_outlined;
    }
  }
}
