import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/categories/domain/repository/category_repository.dart';

class DeleteCategory implements UseCase<void, String> {
  final CategoryRepository _categoryRepository;
  const DeleteCategory(this._categoryRepository);

  @override
  Future<void> call(String id) async {
    return await _categoryRepository.deleteCategory(id);
  }
}
