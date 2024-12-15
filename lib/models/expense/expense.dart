import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense.g.dart';
part 'expense.freezed.dart';

@freezed
class Expense with _$Expense {
  const factory Expense({
    required String type,
    required String category,
    required String categoryIcon,
    String? description,
    required String amount,
    required DateTime date,
  }) = _Expense;

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);
}
