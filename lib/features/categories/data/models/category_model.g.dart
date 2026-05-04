// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    _CategoryModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String,
      isDefault: json['is_default'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(_CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'color': instance.color,
      'icon': instance.icon,
      'is_default': instance.isDefault,
      'created_at': instance.createdAt,
    };
