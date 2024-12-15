// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseImpl _$$ExpenseImplFromJson(Map<String, dynamic> json) =>
    _$ExpenseImpl(
      type: json['type'] as String,
      category: json['category'] as String,
      description: json['description'] as String?,
      amount: json['amount'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ExpenseImplToJson(_$ExpenseImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'category': instance.category,
      'description': instance.description,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
    };
