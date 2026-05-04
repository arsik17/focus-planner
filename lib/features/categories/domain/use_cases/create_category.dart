import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/categories/domain/repository/category_repository.dart';

class CreateCategory implements UseCase<Category, CreateCategoryParams> {
  final CategoryRepository _categoryRepository;
  const CreateCategory(this._categoryRepository);

  @override
  Future<Category> call(CreateCategoryParams params) async {
    return await _categoryRepository.createCategory(
      name: params.name,
      color: params.color,
      icon: params.icon,
    );
  }
}

class CreateCategoryParams {
  final String name;
  final String color;
  final String icon;

  const CreateCategoryParams({
    required this.name,
    required this.color,
    required this.icon,
  });
}
