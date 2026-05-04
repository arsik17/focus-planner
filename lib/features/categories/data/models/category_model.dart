import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:focus_planner/features/categories/domain/entities/category.dart';

part 'category_model.g.dart';
part 'category_model.freezed.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String name,
    required String color,
    required String icon,
    @JsonKey(name: 'is_default') required bool isDefault,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Category toEntity() {
    return Category(
      id: id,
      userId: userId,
      name: name,
      color: color,
      icon: icon,
      isDefault: isDefault,
      createdAt: DateTime.parse(createdAt),
    );
  }

  factory CategoryModel.fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      userId: category.userId,
      name: category.name,
      color: category.color,
      icon: category.icon,
      isDefault: category.isDefault,
      createdAt: category.createdAt.toIso8601String(),
    );
  }
}
