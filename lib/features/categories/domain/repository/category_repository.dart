import 'package:focus_planner/features/categories/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> createCategory({
    required String name,
    required String color,
    required String icon,
  });
  Future<Category> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  });
  Future<void> deleteCategory(String id);
}
