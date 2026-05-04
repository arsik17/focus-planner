import 'package:focus_planner/core/error/server_exception.dart';
import 'package:focus_planner/features/categories/data/models/category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> createCategory({
    required String name,
    required String color,
    required String icon,
  });
  Future<CategoryModel> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  });
  Future<void> deleteCategory(String id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final SupabaseClient _client;

  CategoryRemoteDataSourceImpl(this._client);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _client
          .from('categories')
          .select()
          .order('created_at');

      return (response as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CategoryModel> createCategory({
    required String name,
    required String color,
    required String icon,
  }) async {
    try {
      final userId = _client.auth.currentUser!.id;
      final response = await _client.from('categories').insert({
        'user_id': userId,
        'name': name,
        'color': color,
        'icon': icon,
      }).select().single();

      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CategoryModel> updateCategory({
    required String id,
    required String name,
    required String color,
    required String icon,
  }) async {
    try {
      final response = await _client.from('categories').update({
        'name': name,
        'color': color,
        'icon': icon,
      }).eq('id', id).select().single();

      return CategoryModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _client.from('categories').delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
