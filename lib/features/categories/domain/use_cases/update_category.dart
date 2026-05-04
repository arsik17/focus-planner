import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/categories/domain/repository/category_repository.dart';

class UpdateCategory implements UseCase<Category, UpdateCategoryParams> {
  final CategoryRepository _categoryRepository;
  const UpdateCategory(this._categoryRepository);

  @override
  Future<Category> call(UpdateCategoryParams params) async {
    return await _categoryRepository.updateCategory(
      id: params.id,
      name: params.name,
      color: params.color,
      icon: params.icon,
    );
  }
}

class UpdateCategoryParams {
  final String id;
  final String name;
  final String color;
  final String icon;

  const UpdateCategoryParams({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });
}
