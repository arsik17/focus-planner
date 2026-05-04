import 'package:focus_planner/features/categories/data/datasources/category_remote_data_source.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';
import 'package:focus_planner/features/categories/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Category>> getCategories() async {
    final models = await _remoteDataSource.getCategories();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Category> createCategory({
    required String name,
    required String color,
    required String icon,
  }) async {
    final model = await _remoteDataSource.createCategory(
      name: name,
      color: color,
      icon: icon,
    );
    return model.toEntity();
  }

  @override
  Future<Category> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  }) async {
    final model = await _remoteDataSource.updateCategory(
      id: id,
      name: name,
      color: color,
      icon: icon,
    );
    return model.toEntity();
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _remoteDataSource.deleteCategory(id);
  }
}
