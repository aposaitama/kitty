// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      type: json['type'] as String,
      category: json['category'] as String,
      categoryIcon: json['categoryIcon'] as String,
      backgroundColor: (json['backgroundColor'] as num).toInt(),
      description: json['description'] as String?,
      categoryId: (json['categoryId'] as num?)?.toInt(),
      amount: json['amount'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'category': instance.category,
      'categoryIcon': instance.categoryIcon,
      'backgroundColor': instance.backgroundColor,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
    };
