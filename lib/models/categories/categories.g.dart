// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoriesImpl _$$CategoriesImplFromJson(Map<String, dynamic> json) =>
    _$CategoriesImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      background_color: (json['background_color'] as num).toInt(),
      icon: json['icon'] as String,
      order_index: (json['order_index'] as num).toInt(),
    );

Map<String, dynamic> _$$CategoriesImplToJson(_$CategoriesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'background_color': instance.background_color,
      'icon': instance.icon,
      'order_index': instance.order_index,
    };
