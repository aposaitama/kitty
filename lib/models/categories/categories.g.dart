// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoriesImpl _$$CategoriesImplFromJson(Map<String, dynamic> json) =>
    _$CategoriesImpl(
      name: json['name'] as String,
      backgroundColor: (json['backgroundColor'] as num).toInt(),
      iconPath: json['iconPath'] as String,
      order_index: (json['order_index'] as num).toInt(),
    );

Map<String, dynamic> _$$CategoriesImplToJson(_$CategoriesImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'backgroundColor': instance.backgroundColor,
      'iconPath': instance.iconPath,
      'order_index': instance.order_index,
    };
