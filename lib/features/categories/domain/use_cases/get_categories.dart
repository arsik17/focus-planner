import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/categories/domain/repository/category_repository.dart';

class GetCategories implements UseCase<List<Category>, NoParams> {
  final CategoryRepository _categoryRepository;
  const GetCategories(this._categoryRepository);

  @override
  Future<List<Category>> call(NoParams params) async {
    return await _categoryRepository.getCategories();
  }
}
