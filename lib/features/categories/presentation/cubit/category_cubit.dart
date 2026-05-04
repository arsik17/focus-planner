import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/categories/domain/use_cases/create_category.dart';
import 'package:focus_planner/features/categories/domain/use_cases/delete_category.dart';
import 'package:focus_planner/features/categories/domain/use_cases/get_categories.dart';
import 'package:focus_planner/features/categories/domain/use_cases/update_category.dart';
import 'package:focus_planner/features/categories/presentation/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetCategories _getCategories;
  final CreateCategory _createCategory;
  final UpdateCategory _updateCategory;
  final DeleteCategory _deleteCategory;

  CategoryCubit({
    required GetCategories getCategories,
    required CreateCategory createCategory,
    required UpdateCategory updateCategory,
    required DeleteCategory deleteCategory,
  })  : _getCategories = getCategories,
        _createCategory = createCategory,
        _updateCategory = updateCategory,
        _deleteCategory = deleteCategory,
        super(const CategoryState());

  Future<void> loadCategories() async {
    emit(state.copyWith(status: CategoryStatus.loading, errorMessage: null));

    try {
      final categories = await _getCategories(NoParams());
      emit(state.copyWith(
        status: CategoryStatus.success,
        categories: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> addCategory({
    required String name,
    required String color,
    required String icon,
  }) async {
    try {
      await _createCategory(CreateCategoryParams(
        name: name,
        color: color,
        icon: icon,
      ));
      await loadCategories();
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> editCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  }) async {
    try {
      await _updateCategory(UpdateCategoryParams(
        id: id,
        name: name,
        color: color,
        icon: icon,
      ));
      await loadCategories();
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> removeCategory(String id) async {
    try {
      await _deleteCategory(id);
      await loadCategories();
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
